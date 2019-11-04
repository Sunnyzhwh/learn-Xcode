//
//  PageTitleView.swift
//  douyuzhibo
//
//  Created by Sunny on 2019/10/1.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

private var DscrollLineH = CGFloat(2)
private let DnormalColor: (CGFloat, CGFloat, CGFloat) = (80,80,80)
private let DselectColor: (CGFloat, CGFloat, CGFloat) = (255,128,0)
class PageTitleView: UIView {
    private var titles: [String]
    private var currentIndex = 0
    weak var delegate: PageTitleViewDelegate?
    private lazy var lables: [UILabel] = []
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.bounces = false
        scrollview.scrollsToTop = false
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame:frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageTitleView{
    private func setUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setTitleLables()
        setUpBottomLineAndScrollLine()
    }
    private func setTitleLables(){
        let lableW = frame.width / CGFloat(titles.count)
        let lableH = frame.height - DscrollLineH
        let lableY = CGFloat(0)
        for(index, title) in titles.enumerated(){
            let titleLable = UILabel()
            titleLable.text = title
            titleLable.textAlignment = .center
            titleLable.tag = index
            titleLable.font = UIFont.systemFont(ofSize: 16.0)
            titleLable.textColor = UIColor(r: DnormalColor.0, g: DnormalColor.1, b: DnormalColor.2)
            let lableX = lableW * CGFloat(index)
            titleLable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            titleLable.isUserInteractionEnabled = true
            
            titleLable.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleClicked(_:))))
            scrollView.addSubview(titleLable)
            scrollView.contentInsetAdjustmentBehavior = .never
            lables.append(titleLable)
            
        }
    }
    private func setUpBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        guard let firstLable = lables.first else {return}
        firstLable.textColor = UIColor(r: DselectColor.0, g: DselectColor.1, b: DselectColor.2)
        addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - DscrollLineH, width: firstLable.frame.width, height: DscrollLineH)
    }
}
extension PageTitleView {
    @objc private func titleClicked(_ tapGesture: UITapGestureRecognizer){
        if let currentLabel = tapGesture.view as? UILabel{
            let previousLabel = lables[currentIndex]
            previousLabel.textColor = UIColor(r: DnormalColor.0, g: DnormalColor.1, b: DnormalColor.2)
            currentIndex = currentLabel.tag
            currentLabel.textColor = UIColor(r: DselectColor.0, g: DselectColor.1, b: DselectColor.2)
            let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
            
            UIView.animate(withDuration: 0.15) {
                self.scrollLine.frame.origin.x = scrollLineX
            }
            //MARK:- 代理用来传输tap时的Index
            delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        }
    }
}
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        let sourceLabel = lables[sourceIndex]
        let targetLabel = lables[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        //scrollLine的坐标x的变化设置
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        // 颜色设置渐变
        let colorRange = (DselectColor.0 - DnormalColor.0, DselectColor.1 - DnormalColor.1, DselectColor.2 - DnormalColor.2)
        sourceLabel.textColor = UIColor(r: DselectColor.0 - colorRange.0 * progress, g: DselectColor.1 - colorRange.1 * progress, b: DselectColor.2 - colorRange.2 * progress)
        targetLabel.textColor = UIColor(r: DnormalColor.0 + colorRange.0 * progress, g: DnormalColor.1 + colorRange.1 * progress, b: DnormalColor.2 + colorRange.2 * progress)
        // 记录最新的index
        currentIndex = targetIndex
    }
}
