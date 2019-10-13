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
    
    
    
    //Setting the message Last Message values and User info
    var MESSAGE: Conversation!{
        didSet{
            imgProfile.downloadCachedImage(placeholder: "", urlString: MESSAGE.user.profilePic)
            lblName.text = MESSAGE.user.name
            lblConversation.text = MESSAGE.lastMessage.content as? String
           
        }
    }
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
