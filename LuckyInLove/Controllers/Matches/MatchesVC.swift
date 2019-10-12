//
//  MatchesVC.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class MatchesVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var matchesCollectionView: UICollectionView!
    @IBOutlet weak var btnMatchesMenu: UIButton!
    
    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configCollectionView()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.title = "Matches"
       
    }
    func configUI() {
    }
    //Config Collectionview
    
    func configCollectionView() {
        self.matchesCollectionView.register(UINib(nibName: CollectionViewCellIdentifire.kMatchesCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifire.kMatchesCell)
        
        self.matchesCollectionView.delegate = self
        self.matchesCollectionView.dataSource = self
        self.matchesCollectionView.reloadData()
    }
    @IBAction func MatchesMenuButtonAction(_ sender: Any) {
        self.showAlert(title: "", message: "Coming soon")
    }
    
}

extension MatchesVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((matchesCollectionView.frame.size.width - 20) / 2), height: 318)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:MatchesCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellIdentifire.kMatchesCell, for: indexPath) as! MatchesCell
        
        
        return cell
    }
    
}
