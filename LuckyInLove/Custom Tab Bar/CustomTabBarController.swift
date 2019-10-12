//
//  CustomTabBarController.swift
//  UrbanKiddie
//
//  Created by Rohit Saini on 10/08/18.
//  Copyright © 2018 Appknit. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController,CustomTabBarViewDelegate{

    
    var tabBarView : CustomTabBarView = CustomTabBarView()// Custom Tabbar View Object
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        
        tabBarView = Bundle.main.loadNibNamed("CustomTabBarView", owner: nil, options: nil)?.last as! CustomTabBarView // Loading the Custom Tabbar View
        
        tabBarView.delegate = self
        
        addTabBarView() //Adding Tabbar view Dynamically
        
        
        

        setup() // Setting up the tabbar StoryBoard Controller
        // Do any additional setup after loading the view.
    }
    
//
    
   
    
 
    
    //MARK:- resetTabbarBtn
    func resetTabbarBtn()
    {
        self.tabBarView.Btn1.isSelected = false;
        self.tabBarView.Lbl1.isHighlighted = false;
        self.tabBarView.Lbl1.textColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
        self.tabBarView.Btn2.isSelected = false;
        self.tabBarView.Lbl2.isHighlighted = false;
        self.tabBarView.Lbl2.textColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
        self.tabBarView.Btn3.isSelected = false;
        self.tabBarView.Lbl3.isHighlighted = false;
        self.tabBarView.Lbl3.textColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
        self.tabBarView.Btn4.isSelected = false;
        self.tabBarView.Lbl4.isHighlighted = false;
        self.tabBarView.Lbl4.textColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
        
        
    }
    //MARK:- Setup
    func setup()
    {
        
        
        var viewControllers = [UINavigationController]()

        let navController1 : UINavigationController = STORYBOARD.EXPLORE.instantiateViewController(withIdentifier: "ExploreNavigation") as! UINavigationController
            viewControllers.append(navController1)
        
        let navController2 : UINavigationController = STORYBOARD.MATCHES.instantiateViewController(withIdentifier: "MatchesNavigation") as! UINavigationController
            viewControllers.append(navController2)
        
        let navController3 : UINavigationController = STORYBOARD.CHAT.instantiateViewController(withIdentifier: "ChatNavigation") as! UINavigationController
        viewControllers.append(navController3)
        
        let navController4 : UINavigationController = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "ProfileNavigation") as! UINavigationController
        viewControllers.append(navController4)
        
        self.viewControllers = viewControllers;
      
        self.tabBarView.Btn1.isSelected = true;
        self.tabBarView.Lbl1.isHighlighted = true;
        self.tabSelectedAtIndex(index: 0)
        
    }
    
    func tabSelectedAtIndex(index: Int) {
        setSelectedViewController(selectedViewController: self.viewControllers![index], tabIndex: index)
    }
    
    func setSelectedViewController(selectedViewController:UIViewController, tabIndex:Int)
    {
        
        // pop to root if tapped the same controller twice
        if self.selectedViewController == selectedViewController {
            (self.selectedViewController as! UINavigationController).popToRootViewController(animated: true)
        }
        super.selectedViewController = selectedViewController
    }
    
      //MARK:- addTabBarView
    func addTabBarView()
    {
        self.tabBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tabBarView)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: ((UIScreen.main.bounds.height >= 812) ? 80 : 50)))
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: ((UIScreen.main.bounds.height == 812) ? -34 : 0)))
        self.view.addConstraint(NSLayoutConstraint(item: self.tabBarView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
        self.view.layoutIfNeeded()
    }
    
    //MARK:- Hiding Tabbar
    func tabBarHidden() -> Bool
    {
        return self.tabBarView.isHidden && self.tabBar.isHidden
    }
    
     //MARK:- setTabBarHidden
    func setTabBarHidden(tabBarHidden:Bool)
    {
        self.tabBarView.isHidden = tabBarHidden
        self.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
