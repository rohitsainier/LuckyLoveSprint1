//
//  ExploreVC.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit
import Koloda

class ExploreVC: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var nopeImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var locationView: View_Addition!
    @IBOutlet weak var filterView: View_Addition!
    
    
    var userListArr: [LoginUserDetails] = [LoginUserDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar : CustomTabBarController = self.tabBarController as! CustomTabBarController
        tabBar.setTabBarHidden(tabBarHidden: false)
    }
    
    func configUI() {
        kolodaView.dataSource = self
        kolodaView.delegate = self
        likeImageView.alpha = 0
        nopeImageView.alpha = 0
        getUserList()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func clickToLeftSwipeBtn(_ sender: UIButton) {
        kolodaView.swipe(.left)
    }
    
    @IBAction func clickToRightSwipeBtn(_ sender: UIButton) {
        kolodaView.swipe(.right)
        Message.send(message: Message(type: .text, content: "First Message just for testing nothing else", owner: MessageOwner.sender, timestamp: Date().timeIntervalSince1970, isRead: false), toID: "shhgsaj2136") { (success) in
            if success{
                self.view.sainiShowToast(message: "Message sent successfully!")
            }
        }
    }
    
    
    //MARK:- 
    private func getUserList(){
        let params: [String: Any] = [String: Any]()
        GCD.USER.USERS_LIST.async {
            APIManager.sharedInstance.I_AM_COOL(params: params, api: API.USER.UsersList, Loader: true, isMultipart: false) { (responseData) in
                if responseData != nil{                             //if response is not empty
                    do {
                        let success = try JSONDecoder().decode(UserListModel.self, from: responseData!) // decode the response into SignUpModel
                        switch success.error{
                        case false:
                            self.userListArr = success.users
                            DispatchQueue.main.async {
                                self.kolodaView.reloadData()
                            }
                            
                        default:
                            print("Error in fetching user list")
                        }
                    }
                    catch let err {
                        print("Err", err)
                    }
                }
            }
        }
    }
    
}


// MARK: KolodaViewDelegate
extension ExploreVC: KolodaViewDelegate{
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
      
        self.kolodaView.resetCurrentCardIndex()
    }
    func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool {
        
        if direction == .left || direction == .right {
            return true
        }
        return false
    }
    
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
      
        //fading the color acc. to the movement of view
        switch direction {
        case .left:
            
            likeImageView.isHidden = true
            nopeImageView.isHidden = false
            nopeImageView.alpha = abs(finishPercentage)
            break
        case .right:
           
            likeImageView.isHidden = false
            nopeImageView.isHidden = true
            likeImageView.alpha = abs(finishPercentage)
             break
        default:
            
            likeImageView.isHidden = true
            nopeImageView.isHidden = true
            likeImageView.alpha = 0
            nopeImageView.alpha = 0
            break
        }
        
    }
    
    func kolodaDidResetCard(_ koloda: KolodaView) {
        likeImageView.isHidden = true
        nopeImageView.isHidden = true
        likeImageView.alpha = 0
        nopeImageView.alpha = 0
    }
    
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
        
    }

}


// MARK: KolodaViewDataSource

extension ExploreVC: KolodaViewDataSource {
    
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return userListArr.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        switch direction {
        case .left:
            break
            
        case .right:
            break
            
        default:
            break
            
        }
       
    }
    func kolodaPanFinished(_ koloda: KolodaView, card: DraggableCardView) {
        likeImageView.isHidden = true
        nopeImageView.isHidden = true
        likeImageView.alpha = 0
        nopeImageView.alpha = 0
    }
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
 
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
         let cardView = Bundle.main.loadNibNamed("SwipeCardView", owner: self, options: nil)![0] as! SwipeCardView
        cardView.profilePic.layer.cornerRadius = 20
        cardView.profilePic.downloadCachedImage(placeholder: "5", urlString: API.BASE_URL + (userListArr[index].userPic?.img2 ?? ""))
        cardView.profileUsernameLbl.text = userListArr[index].fname +  userListArr[index].lname
        cardView.profileUserBio.text = userListArr[index].email
       return cardView
    }

 
}
