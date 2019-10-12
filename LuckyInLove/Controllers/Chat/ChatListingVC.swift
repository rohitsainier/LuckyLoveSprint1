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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableviewConfig()
    }
    func configUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.title = "Chat"
       
    }
    func tableviewConfig(){
        self.tblChatlisting.register(UINib(nibName: TableViewCellIdentifire.kChatListingCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifire.kChatListingCell)
        self.tblChatlisting.separatorStyle = .none
        self.tblChatlisting.delegate = self
        self.tblChatlisting.dataSource = self
        self.tblChatlisting.reloadData()
    }

    @IBAction func ChatMenuButtonAction(_ sender: Any) {
        self.showAlert(title: "", message: "Coming soon")
    }
}
extension ChatListingVC : UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource, Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblChatlisting.dequeueReusableCell(withIdentifier: TableViewCellIdentifire.kChatListingCell, for: indexPath) as! ChatListingCell
        
       
        return cell
        
    }
    
}
