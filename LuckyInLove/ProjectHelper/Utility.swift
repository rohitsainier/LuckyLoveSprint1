//
//  Utility.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//


import UIKit
import Toaster
import SDWebImage

class SKSearchBar: UISearchBar {
    
    private enum SubviewKey: String {
        case searchField, clearButton, cancelButton,  placeholderLabel
    }
    
    // Button/Icon images
    public var clearButtonImage: UIImage?
    public var resultsButtonImage: UIImage?
    public var searchImage: UIImage?
    
    // Button/Icon colors
    public var searchIconColor: UIColor?
    public var clearButtonColor: UIColor?
    public var cancelButtonColor: UIColor?
    public var capabilityButtonColor: UIColor?
    
    // Text
    public var textColor: UIColor?
    public var placeholderColor: UIColor?
    public var cancelTitle: String?
    
    // Cancel button to change the appearance.
    public var cancelButton: UIButton? {
        guard showsCancelButton else { return nil }
        return self.value(forKey: SubviewKey.cancelButton.rawValue) as? UIButton
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let cancelColor = cancelButtonColor {
            self.cancelButton?.setTitleColor(cancelColor, for: .normal)
        }
        if let cancelTitle = cancelTitle {
            self.cancelButton?.setTitle(cancelTitle, for: .normal)
        }
        
        guard let textField = self.value(forKey: SubviewKey.searchField.rawValue) as? UITextField else { return }
        
        if let clearButton = textField.value(forKey: SubviewKey.clearButton.rawValue) as? UIButton {
            update(button: clearButton, image: clearButtonImage, color: clearButtonColor)
        }
        if let resultsButton = textField.rightView as? UIButton {
            update(button: resultsButton, image: resultsButtonImage, color: capabilityButtonColor)
        }
        if let searchView = textField.leftView as? UIImageView {
            searchView.image = (searchImage ?? searchView.image)?.withRenderingMode(.alwaysTemplate)
            if let color = searchIconColor {
                searchView.tintColor = color
            }
        }
        if let placeholderLabel =  textField.value(forKey: SubviewKey.placeholderLabel.rawValue) as? UILabel,
            let color = placeholderColor {
            placeholderLabel.textColor = color
        }
        if let textColor = textColor  {
            textField.textColor = textColor
        }
    }
    
    private func update(button: UIButton, image: UIImage?, color: UIColor?) {
        let image = (image ?? button.currentImage)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        if let color = color {
            button.tintColor = color
        }
    }
}


extension UIView {
//MARK:- sainiRoundCorners
    func sainiRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
    
    //MARK:- sainiShowLoader
    func sainiShowLoader(loaderColor: UIColor, backgroundColor: UIColor = UIColor.clear) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = backgroundView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .white
        activityIndicator.color = loaderColor
        activityIndicator.startAnimating()
        //self.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    
    //MARK:- sainiRemoveLoader
    func sainiRemoveLoader() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        //self.isUserInteractionEnabled = true
    }
}

extension UITextField {
    //MARK:- sainiSetLeftPaddingPoints
    func sainiSetLeftPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    //MARK:- sainiSetRightPadding
    func sainiSetRightPadding(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


/// Layout constraint to calculate size based on multiplier.
class PercentLayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable var marginPercent: CGFloat = 0
    
    var screenSize: (width: CGFloat, height: CGFloat) {
        return (UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard marginPercent > 0 else { return }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(layoutDidChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    /**
     Re-calculate constant based on orientation and percentage.
     */
    @objc func layoutDidChange() {
        guard marginPercent > 0 else { return }
        
        switch firstAttribute {
        case .top, .topMargin, .bottom, .bottomMargin:
            constant = screenSize.height * marginPercent
        case .leading, .leadingMargin, .trailing, .trailingMargin:
            constant = screenSize.width * marginPercent
        default: break
        }
    }
    
    deinit {
        guard marginPercent > 0 else { return }
        NotificationCenter.default.removeObserver(self)
    }
}


class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}

//MARK:- Toast
func displayToast(_ message:String)
{
    let toast = Toast(text: NSLocalizedString(message, comment: ""))
    toast.show()
}

//MARK:- toJson
func toJson(_ dict:[String:Any]) -> String{
    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)
    return jsonString!
}

//MARK:- Loader
func showLoader()
{
    AppDelegate().sharedDelegate().showLoader()
}
func removeLoader()
{
    AppDelegate().sharedDelegate().removeLoader()
}

func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970*1000)
}


extension String {
    var isValidEmail: Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension UIImageView{
    func downloadCachedImage(placeholder: String,urlString: String){
        self.sainiShowLoader(loaderColor: #colorLiteral(red: 0.06274509804, green: 0.1058823529, blue: 0.2235294118, alpha: 1))
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        let placeholder = UIImage(named: placeholder)
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType,_ ) in
            self.sainiRemoveLoader()
            guard image != nil else {
                self.sainiRemoveLoader()
                return
            }
            guard cacheType != .memory, cacheType != .disk else {
                self.image = image
                self.sainiRemoveLoader()
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.sainiRemoveLoader()
                self.image = image
                return
            }, completion: nil)
        }
    }
}

//Image Compression to 10th
func compressImage(image: UIImage) -> Data {
    // Reducing file size to a 10th
    var actualHeight : CGFloat = image.size.height
    var actualWidth : CGFloat = image.size.width
    let maxHeight : CGFloat = 1920.0
    let maxWidth : CGFloat = 1080.0
    var imgRatio : CGFloat = actualWidth/actualHeight
    let maxRatio : CGFloat = maxWidth/maxHeight
    var compressionQuality : CGFloat = 0.5
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if (imgRatio < maxRatio) {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        } else {
            actualHeight = maxHeight
            actualWidth = maxWidth
            compressionQuality = 1
        }
    }
    let rect = CGRect(x: 0.0, y: 0.0, width:actualWidth, height:actualHeight)
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img!.jpegData(compressionQuality: compressionQuality)
    UIGraphicsEndImageContext();
    return imageData!
}

//func getDifferenceFromCurrentTimeInHourInDays(_ timestamp : Double) -> String
//{
//    let interval : Int = getDifferenceFromCurrentTime(timestamp)
//    
//    let second : Int = interval
//    let minutes : Int = interval/60
//    let hours : Int = interval/(60*60)
//    let days : Int = interval/(60*60*24)
//    let week : Int = interval/(60*60*24*7)
//    let months : Int = interval/(60*60*24*30)
//    let years : Int = interval/(60*60*24*30*12)
//    
//    var timeAgo : String = ""
//    if  second < 60
//    {
//        timeAgo = (second < 3) ? "Just Now" : (String(second) + "s")
//    }
//    else if minutes < 60
//    {
//        timeAgo = String(minutes) + "m"
//    }
//    else if hours < 24
//    {
//        timeAgo = String(hours) + "h"
//    }
//    else if days < 30
//    {
//        timeAgo = String(days) + " "  + ((days > 1) ? "days" : "day")
//    }
//    else if week < 4
//    {
//        timeAgo = String(week) + " "  + ((week > 1) ? "weeks" : "week")
//    }
//    else if months < 12
//    {
//        timeAgo = String(months) + " "  + ((months > 1) ? "months" : "month")
//    }
//    else
//    {
//        timeAgo = String(years) + " "  + ((years > 1) ? "years" : "year")
//    }
//    
//    if second > 3 {
//        timeAgo = timeAgo + " ago"
//    }
//    return timeAgo
//}
