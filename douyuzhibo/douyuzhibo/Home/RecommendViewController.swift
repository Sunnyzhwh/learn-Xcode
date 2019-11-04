//
//  RecommendViewController.swift
//  douyuzhibo
//
//  Created by Sunny on 2019/10/2.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
private let itemMargin = CGFloat(10)
private let itemWidth = (DScreenWidth - itemMargin * 3) / 2
private let itemHeight = itemWidth * 3 / 4
private let prettyItemH = itemWidth * 4 / 3
private let normalID = "normal"
private let headerHeight = CGFloat(50)
private let headerID = "header"
private let preetyID = "preety"
class RecommendViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sect = 12
        if section == 0 {
            sect = 12
        }else{
            sect = 4
        }
        return sect
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: preetyID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalID, for: indexPath)
        }
        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        reuseView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return reuseView
    }

    //MARK:-设置不同item的尺寸，遵循UICollectionViewDelegateFlowLayout协议
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: itemWidth, height: prettyItemH)
        }else{
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: DScreenWidth, height: headerHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.autoresizingMask = [.flexibleHeight, .flexibleWidth] //设置view自动适配控制器大小
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: normalID)
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: normalID)
        collectionView.register(UINib(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: preetyID)
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        // Do any additional setup after loading the view.
    }
    

  

}
extension RecommendViewController{
    private func setUI(){
        view.addSubview(collectionView)
    }
}
