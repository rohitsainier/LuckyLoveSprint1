//
//  MatchesCell.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class MatchesCell: UICollectionViewCell {

    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOnline: UILabel!
    @IBOutlet weak var lblActiveStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
        // Initialization code
    }

    func configUI() { 
        self.imgProfile.layer.cornerRadius = 20.0
        self.lblOnline.layer.cornerRadius = self.lblOnline.frame.height / 2
        self.lblOnline.backgroundColor = UIColor.green
    }
}
