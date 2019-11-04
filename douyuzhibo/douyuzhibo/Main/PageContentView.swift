//
//  PageContentView.swift
//  douyuzhibo
//
//  Created by Sunny on 2019/10/1.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}
let ContentCellID = "contentCellID"
class PageContentView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    private var isForbidScrollDelegate = false
    //MARK:-定义一个变量来存取scrollview的偏移值
    private var startOffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate { return }
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 判断为左滑
            let ratio = currentOffsetX / scrollViewWidth
            progress = ratio - CGFloat(floor(Double(ratio)))
            sourceIndex = Int(currentOffsetX / scrollViewWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count
            {
                targetIndex = childVCs.count - 1
            }
            // 如果完全滑到位
            if currentOffsetX - startOffsetX == scrollViewWidth{
                progress = 1.0
                targetIndex = sourceIndex
            }
            
        }else{ //判断为右滑
            let ratio = currentOffsetX / scrollViewWidth
            progress = 1 - (ratio - CGFloat(floor(Double(ratio))))
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            // 如果完全滑到位
            if  startOffsetX - currentOffsetX == scrollViewWidth{
                progress = 1.0
                sourceIndex = targetIndex
            }
        }
//        print("current_\(currentOffsetX) startOffsetX_\(startOffsetX)   progress_\(progress)   source_\(sourceIndex)  target_\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("\(childVCs.count)")
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
    private var childVCs: [UIViewController]
    private weak var parentVC: UIViewController?
    private lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = (self?.bounds.size)!
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.bounces = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return cv
    }()
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageContentView{
    private func setUI(){
        childVCs.forEach { parentVC?.addChild($0) }
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
}
extension PageContentView{
    func setCurrentIndex(index: Int) {
        isForbidScrollDelegate = true
        let offSetX = CGFloat(index) *  collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}
