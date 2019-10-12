//
//  ProfileHeaderCell.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {

    @IBOutlet weak var BioLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configUI()
    }
    
    
    private func configUI(){
        profilePic.layer.cornerRadius =  profilePic.frame.height / 2
        profilePic.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
