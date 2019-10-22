//
//  ChatControllerVC.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit
import GrowingTextView

class ChatControllerVC: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var chatTextView: GrowingTextView!
    @IBOutlet weak var tableView: UITableView!
    var ReceiverID: String = ""
    var userdetails:User!
    private var items = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar : CustomTabBarController = self.tabBarController as! CustomTabBarController
        tabBar.setTabBarHidden(tabBarHidden: true)
    }
    
    private func configUI(){
        userNameLbl.text = userdetails.name
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        profilePic.layer.masksToBounds = true
        profilePic.downloadCachedImage(placeholder: "user_avatar", urlString: userdetails.profilePic)
        tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
       
       func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return items.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell else{
               return UITableViewCell()
           }
           cell.MSG = items[indexPath.row]
           
           return cell
       }
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           
           if tableView.isDragging {
               cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
               UIView.animate(withDuration: 0.3, animations: {
                   cell.transform = CGAffineTransform.identity
               })
               
           }
       }
       
      
       
       
       
    
    
    //Downloads messages
    func fetchData() {
        Message.downloadAllMessages(forUserID: ReceiverID, completion: {[weak weakSelf = self] (message) in
            weakSelf?.items.append(message)
            weakSelf?.items.sort{ $0.timestamp < $1.timestamp }
            DispatchQueue.main.async {
                if let state = weakSelf?.items.isEmpty, state == false {
                    weakSelf?.tableView.reloadData()
                    weakSelf?.tableView.scrollToRow(at: IndexPath.init(row: self.items.count - 1, section: 0), at: .bottom, animated: false)
                }
            }
        })
        Message.markMessagesRead(forUserID: ReceiverID)
    }
    
    func composeMessage(type: MessageType, content: Any)  {
        let message = Message.init(type: type, content: content, owner: .sender, timestamp: (Double(Date().timeIntervalSince1970)), isRead: false)
        Message.send(message: message, toID: ReceiverID, completion: {(_) in
            
        })
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let message = chatTextView.text{
            if message == ""{
                return
            }
            self.composeMessage(type: MessageType.text, content: message)
            chatTextView.text = ""
            //chatTextView.resignFirstResponder()
        }
       
    }
    
    @IBAction func clickBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
