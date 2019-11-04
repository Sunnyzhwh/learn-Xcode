//
//  HomeViewController.swift
//  douyuzhibo
//
//  Created by Sunny on 2019/9/30.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

let DPageTitleHeight: CGFloat = 40

class HomeViewController: UIViewController, PageTitleViewDelegate, PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    //MARK：-设置contentview来接收title点击时的Index
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(index: index)
    }
    
    //MARK:- 设置iPhoneX的top安全区
    var topSafe: CGFloat {
        get{
            return view.safeAreaInsets.top
        }
    }
    var bottomSafe: CGFloat {
        get{
            return view.safeAreaInsets.bottom
        }
    }
    private lazy var pageTitleView: PageTitleView = {
        let rect = CGRect(x: 0, y: topSafe, width: DScreenWidth, height: DPageTitleHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: rect, titles: titles)
        return titleView
    }()
    
    private lazy var pageContenView: PageContentView = { [weak self] in
        let rect = CGRect(x: 0, y: topSafe + DPageTitleHeight, width: DScreenWidth, height: DScrennHeight - topSafe - DPageTitleHeight - bottomSafe)
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        let vc = PageContentView(frame: rect, childVCs: childVCs, parentVC: self)
        return vc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setUpUI()
        pageTitleView.delegate = self
        pageContenView.delegate = self
    }

}
extension HomeViewController{
    private func setUpUI(){
        
        setUpNavgationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContenView)
    }
    private func setUpNavgationBar(){
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(normalImage: "image_my_history", highlightedImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(normalImage: "btn_search", highlightedImage: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem(normalImage: "Image_scan", highlightedImage: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, scanItem]
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImage: "logo")
    }
}
extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        let R = r / 255.0
        let G = g / 255.0
        let B = b / 255.0
        self.init(red: R, green: G, blue: B, alpha: 1.0)
    }
}

