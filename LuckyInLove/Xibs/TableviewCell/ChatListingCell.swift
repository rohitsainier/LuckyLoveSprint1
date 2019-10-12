//
//  ChatListingCell.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class ChatListingCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblConversation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
