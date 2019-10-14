//
//  ProfileVC.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnProfileMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar : CustomTabBarController = self.tabBarController as! CustomTabBarController
        tabBar.setTabBarHidden(tabBarHidden: false)
    }
    
    func configUI() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib.init(nibName: "ProfileHeaderCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderCell")
        tableView.register(UINib.init(nibName: "ProfileFooterCell", bundle: nil), forCellReuseIdentifier: "ProfileFooterCell")

      
    }

    @IBAction func ProfileMenuButtonAction(_ sender: Any) {
        self.showAlert(title: "", message: "Coming soon")
    }
}


//Mark:- TableView Delegate Methods
extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath) as? ProfileHeaderCell else{
                return UITableViewCell()
            }
            cell.BioLbl.text = "🎽 Actress"
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFooterCell", for: indexPath) as? ProfileFooterCell else{
                return UITableViewCell()
            }
            cell.INFO = #imageLiteral(resourceName: "person-fill_selected")
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionViewHeightConstraint.constant = cell.collectionView.contentSize.height
            return cell
        }
        
    }
    
    
}


