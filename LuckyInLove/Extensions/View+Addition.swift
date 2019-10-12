//
//  View+Addition.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class View_Addition: UIView {
    
    @IBInspectable var cornerRadious : CGFloat = 5
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    @IBInspectable let shadowOffSetWidth : Int = 0
    @IBInspectable let shadowOffSetHeight : Int =  1
    
    @IBInspectable var shadowOpacity : CGFloat = 0.2
    
    override func layoutSubviews(){
        layer.cornerRadius = cornerRadious
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowpath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadious)
        layer.shadowPath =  shadowpath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
    
    
}


