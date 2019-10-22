//
//  ChatListingVC.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit


class ChatListingVC: UIViewController {

     
    @IBOutlet weak var tblChatlisting: UITableView!
    @IBOutlet weak var btnChatMenu: UIButton!
    private var items = [Conversation]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
        fetchMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBar : CustomTabBarController = self.tabBarController as! CustomTabBarController
        tabBar.setTabBarHidden(tabBarHidden: false)
        self.tableviewConfig()
    }
    func configUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.title = "Chat"
       
    }
    func tableviewConfig(){
        self.tblChatlisting.register(UINib(nibName: TableViewCellIdentifire.kChatListingCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifire.kChatListingCell)
        self.tblChatlisting.separatorStyle = .none
    }

    @IBAction func ChatMenuButtonAction(_ sender: Any) {
        self.showAlert(title: "", message: "Coming soon")
    }
}
extension ChatListingVC : UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource, Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblChatlisting.dequeueReusableCell(withIdentifier: TableViewCellIdentifire.kChatListingCell, for: indexPath) as! ChatListingCell
        cell.MESSAGE = items[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: ChatControllerVC = STORYBOARD.CHAT.instantiateViewController(withIdentifier: "ChatControllerVC") as! ChatControllerVC
        vc.ReceiverID = items[indexPath.row].user.id
        vc.userdetails = items[indexPath.row].user
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Downloads conversations
       func fetchMessages() {
         
           self.items.removeAll()
           Conversation.showConversations { (conversations) in
               self.items = conversations
               self.items.sort{ $0.lastMessage.timestamp > $1.lastMessage.timestamp }
               if self.items.count == 0{
//                   DispatchQueue.main.async {
//                       self.noMessageAvailable.isHidden = false
//                   }
               }
               else{
                   DispatchQueue.main.async {
                       //self.noMessageAvailable.isHidden = true
                       self.tblChatlisting.reloadData()
                       for conversation in self.items {
                           if conversation.lastMessage.isRead == false {
                               //self.playSound()
                               break
                           }
                       }
                   }
               }
             
           }
           
       }
    
}


