//
//  Utilities.swift
//  LuckyInLove
//
//  Created by Ruchit on 05/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

private var kAssociationKeyMaxLength: Int = 0

enum PasswordError: String, Error {
    case needsAtLeastSixCharacters/*
     case needsAtLeastOneLetter
     case needsAtLeastOneDecimalDigit*/
}
class Utilities: NSObject {
    
    //MARK: Check internet connection
    static func checkInternetConnection() -> Bool
    {
        if(APIManager.isConnectedToNetwork())
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    //MARK:- Check Empty Value
    class func checkEmptyValue(value:AnyObject) -> AnyObject {
        
        if value is NSNull
        {
            return "" as AnyObject
        }
        else if value is NSNumber
        {
            return String(format:"%d", Int(truncating: value as! NSNumber)) as AnyObject
        }
        return value
    }
    
    //MARK: Get trimmed string
    static func trimWhiteSpaces(_ stringToTrim: String) -> String {
        let string: String = stringToTrim
        let trimmedString: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    //MARK:- Validation
    //Validate email
    class func isValidEmail(_ strEmail:String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: strEmail)
    }
    
    //validate TextField
    class func validateTextFieldString(object:String?,validationMessage:String?)->Bool {
        let str = object?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (str?.count)! > 0 {
            return true
        }
        
        self.showAlertService(title: "", message: validationMessage)
        return false
    }
    
    //validate email
    class func validateEmail(email:String?,validationMessage:String)->Bool
    {
        if validateTextFieldString(object: email, validationMessage: validationMessage)
        {
            if !isValidEmail(email!)
            {
                self.showAlertService(title: "", message: AlertMessages.kEmailValidate)
                
                return false
            }
            return true
        }
        return false
    }
    
    //validate password
    class func validatePassword(object:String?,validationMessage:String?)->Bool
    {
        do {
            
            try object?.validatePassword()
            //print("valid password action")
            return true
        } catch let error as PasswordError {
            //print("Password error:", error)  // Password error: needsAtLeastOneLetter
            switch error {
            case .needsAtLeastSixCharacters:
                self.showAlertService(title: "", message: validationMessage)
                return false/*
                 case .needsAtLeastOneLetter:
                 return false
                 case .needsAtLeastOneDecimalDigit:
                 return false*/
            }
            
        } catch {
            print("error:", error)
        }
        return false
    }
    
    
    class func showAlertService(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AlertButtonTitle.kOK, style: UIAlertAction.Style.default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Date conversion function
    
    //Get only DATE in string
    class func getDateStr(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "dd"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    //Get only Day in String
    class func getDayStr(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "EEE"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    //Get only TIME in string
    class func getTimeStr(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.timeZone = TimeZone(secondsFromGMT: -3600*12) // backend team will send proper time then comment this line
            dateFormatter.dateFormat = "hh:mm a"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    //Get only MONTH in string
    class func getMonthStr(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "MMM"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    //Get only YEAR in string
    class func getYearStr(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "yyyy"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    class func getDateToString(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  //
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "MMM dd, yyyy  hh:mm a" //"dd-MMM-yyyy hh:mm"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    class func getDateToStringMMMDDYYYY(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "MMM dd, yyyy"  //
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //"dd-MMM-yyyy hh:mm"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    class func getDateToStr(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  //
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "MMM dd, yyyy" //"dd-MMM-yyyy hh:mm"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    class func getDateToStringDateOnly(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "MMM dd, yyyy" //"dd-MMM-yyyy hh:mm"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    class func setDateToString(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    class func setDateTimeToString(strDateTime: String) -> String {
        if strDateTime != "" {
            let myDate = strDateTime
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "MMM dd, yyyy  hh:mm a"
            let date = dateFormatter.date(from:myDate)!
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let dateString = dateFormatter.string(from:date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    //Calculate age
    class func getAgeFromDOF(date: String) -> (Int) {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM dd, yyyy"
        let dateOfBirth = dateFormater.date(from: date)
        
        let calender = Calendar.current
        
        let dateComponent = calender.dateComponents([.year, .month, .day], from:
            dateOfBirth!, to: Date())
        
        return (dateComponent.year!)
    }
}

extension String {
    //MARK:- Password validation
    func validatePassword() throws  {
        guard self.count > 5
            else { throw PasswordError.needsAtLeastSixCharacters }
        /*guard rangeOfCharacter(from: .letters) != nil
         else { throw PasswordError.needsAtLeastOneLetter }
         guard rangeOfCharacter(from: .decimalDigits) != nil
         else { throw PasswordError.needsAtLeastOneDecimalDigit }*/
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UITextField {
    
    // Set Padding of TextField
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
    
}

extension UIButton {
    // This function returns perticular corner - corner radius of Textfield
    func roundedButton(width:Double,height:Double){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.topLeft, .bottomLeft],
                                     cornerRadii:CGSize(width:width, height:height))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}

public extension UISearchBar {
    
    func setNewcolor(color: UIColor) {
        let clrChange = subviews.flatMap { $0.subviews }
        guard let sc = (clrChange.filter { $0 is UITextField }).first as? UITextField else { return }
        sc.textColor = color
    }
}

extension UIView {
    func addGradientWithColor(color: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, color.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func decorateView(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    //https://stackoverflow.com/questions/12091916/uiview-with-a-dashed-line
    func addDashedBorder() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
}

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AlertButtonTitle.kOK, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Empty screen manage
    
    func HandleEmptytableView(strmessage : String, tableview: UITableView)
    {
        let EmptyBackGroundView = UIView.init(frame: tableview.frame)
        
        /*
         * NOTE: Below Code is commented because if in future at empty screen
         *       Image needs to add at that time only remove comment and use it.
         *
         
         let netWorkImageView = UIImageView.init(image: UIImage.init(named: "ic_no_data_available.png"))
         netWorkImageView.contentMode = .bottom
         netWorkImageView.frame = CGRect(x: (self.view.frame.size.width - 100)/2, y: (self.view.frame.size.height-100)/2 - 50, width: 100, height: 100)
         EmptyBackGroundView.addSubview(netWorkImageView)
         */
        
        let messageLabel = UILabel.init()
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            messageLabel.frame = CGRect(x: (EmptyBackGroundView.bounds.size.width-300)/2, y: (EmptyBackGroundView.bounds.size.height-100)/2 + 20, width: 300, height: 100)
        }
        else {
            messageLabel.frame = CGRect(x: 10, y: (EmptyBackGroundView.bounds.size.height-100)/2 + 20, width: EmptyBackGroundView.bounds.size.width-20, height: 100)
        }
        messageLabel.text = strmessage
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        EmptyBackGroundView .addSubview(messageLabel)
        
        tableview.backgroundView = EmptyBackGroundView
        tableview.backgroundView?.isHidden = false
        tableview.separatorColor = UIColor.clear
    }
    
    //MARK: Empty screen manage
    
    func HandleEmptyCollectionView(strmessage : String, collectionView: UICollectionView)
    {
        let EmptyBackGroundView = UIView.init(frame: collectionView.frame)
        
        /*
         * NOTE: Below Code is commented because if in future at empty screen
         *       Image needs to add at that time only remove comment and use it.
         *
         
         let netWorkImageView = UIImageView.init(image: UIImage.init(named: "ic_no_data_available.png"))
         netWorkImageView.contentMode = .bottom
         netWorkImageView.frame = CGRect(x: (self.view.frame.size.width - 100)/2, y: (self.view.frame.size.height-100)/2 - 50, width: 100, height: 100)
         EmptyBackGroundView.addSubview(netWorkImageView)
         */
        
        let messageLabel = UILabel.init()
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            messageLabel.frame = CGRect(x: (EmptyBackGroundView.bounds.size.width-300)/2, y: (EmptyBackGroundView.bounds.size.height-100)/2 + 20, width: 300, height: 100)
        }
        else {
            messageLabel.frame = CGRect(x: 10, y: (EmptyBackGroundView.bounds.size.height-100)/2 + 20, width: EmptyBackGroundView.bounds.size.width-20, height: 100)
        }
        messageLabel.text = strmessage
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        EmptyBackGroundView .addSubview(messageLabel)
        
        collectionView.backgroundView = EmptyBackGroundView
        collectionView.backgroundView?.isHidden = false
    }
    
    
}


extension UITableViewCell {
    //MARK: Empty screen manage
    
    func HandleEmptyCollectionView(strmessage : String, collectionView: UICollectionView)
    {
        let EmptyBackGroundView = UIView.init(frame: collectionView.frame)
        
        /*
         * NOTE: Below Code is commented because if in future at empty screen
         *       Image needs to add at that time only remove comment and use it.
         *
         
         let netWorkImageView = UIImageView.init(image: UIImage.init(named: "ic_no_data_available.png"))
         netWorkImageView.contentMode = .bottom
         netWorkImageView.frame = CGRect(x: (self.view.frame.size.width - 100)/2, y: (self.view.frame.size.height-100)/2 - 50, width: 100, height: 100)
         EmptyBackGroundView.addSubview(netWorkImageView)
         */
        
        let messageLabel = UILabel.init()
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            messageLabel.frame = CGRect(x: (EmptyBackGroundView.bounds.size.width-300)/2, y: (EmptyBackGroundView.bounds.size.height-100)/2 + 20, width: 300, height: 100)
        }
        else {
            messageLabel.frame = CGRect(x: 10, y: (EmptyBackGroundView.bounds.size.height-100)/2 + 20, width: EmptyBackGroundView.bounds.size.width-20, height: 100)
        }
        messageLabel.text = strmessage
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        EmptyBackGroundView .addSubview(messageLabel)
        
        collectionView.backgroundView = EmptyBackGroundView
        collectionView.backgroundView?.isHidden = false
    }
}

//MARK: -Terms & condition and Privacy policy label under line and tapgester
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset =  CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
