//
//  ChatCell.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    //BubbleType
    enum ChatBubbleType{
        case incoming
        case outgoing
    }
    
    
    //CHAT Cell OUTLETS
    @IBOutlet weak var chatBackgroundView: UIView!
    @IBOutlet weak var timeDateLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chatStackView: UIStackView!
    @IBOutlet weak var chatText: UITextView!
    
    
    
    var MSG: Message!{
        didSet{
            if MSG.owner == .receiver{
                chatText.text = MSG.content as? String
                userName.text = ""
                timeDateLbl.text = ""
                UpdateChatCellAlignment(type: ChatCell.ChatBubbleType.outgoing)
            }
            else{
                chatText.text = MSG.content as? String
                userName.text = ""
                timeDateLbl.text = ""
                UpdateChatCellAlignment(type: ChatCell.ChatBubbleType.incoming)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        SetChatCellAppearence()
        
    }
    
    //MARK:- SetChatCellAppearence
    private func SetChatCellAppearence(){
        chatBackgroundView.layer.cornerRadius = 20
    }
    
    
    //MARK:- UpdateChatCellAlignment
    func UpdateChatCellAlignment(type: ChatBubbleType){
        if type == .incoming{
            chatStackView.alignment = .leading
            chatText.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            chatBackgroundView.backgroundColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
        }
        else if type == .outgoing{
            chatStackView.alignment = .trailing
            chatText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            chatBackgroundView.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
