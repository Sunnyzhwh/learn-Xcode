//
//  lotteryViewController.swift
//  T_minus
//
//  Created by Sunny on 2019/10/25.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
let screenWidth = UIScreen.main.bounds.width
class lotteryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var startNum = 1
    var endNum = 100
    var arr: [String] = []
    var luckyArr: [String] = []
    var timer: Timer?
    var startFlag = false
    var labelArr: [UILabel] = []
    var startButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: screenWidth / 2 - 30, y: 400, width: 60, height: 40)
        btn.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        btn.setTitle("开始", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    var stopButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: screenWidth / 2 - 30, y: 480, width: 60, height: 40)
        btn.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        btn.setTitle("停止", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lottery", for: indexPath)
        cell.backgroundColor = UIColor.white
        labelArr[indexPath.row].removeFromSuperview()
        labelArr[indexPath.row].frame = cell.contentView.bounds
        labelArr[indexPath.row].text = arr[indexPath.row]
        labelArr[indexPath.row].textAlignment = .center
        labelArr[indexPath.row].textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        cell.contentView.addSubview(labelArr[indexPath.row])
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    var lotteryPool: [String] = []
    private lazy var lotteryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (screenWidth / 4) - 20, height: 36)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: 240), collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "lottery")
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.orange
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        print(startNum)
        print(endNum)
        view.addSubview(lotteryCollection)
        addPool()
        addLabel()
        arr.shuffle()
        view.addSubview(startButton)
        view.addSubview(stopButton)
        startButton.addTarget(self, action: #selector(startTouch), for: .touchDown)
        stopButton.addTarget(self, action: #selector(stopTouch), for: .touchDown)
    }
    private func addPool() {
        for item in startNum ... endNum {
            var str = String(item + 1)
            switch str.count{
            case 1: str.insert(contentsOf: "00", at: str.startIndex)
            case 2: str.insert(contentsOf: "0", at: str.startIndex)
            case 3: print(str)
            default: break
            }
            arr.append(str)
        }
    }
    private func addCycleTimer() {
        timer = Timer(fireAt: Date(timeIntervalSinceNow: 0), interval: 0.02, target: self, selector: #selector(changeNumber), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    private func removeCycleTimer() {
        timer?.invalidate()
        timer = nil
    }
    @objc func changeNumber() {
        arr.shuffle()
        lotteryCollection.reloadData()
        
    }
    @IBAction private func startTouch(_ sender: UIButton) {
        if startFlag == false {
            addCycleTimer()
            startFlag = true
        }
    }
    @IBAction private func stopTouch(_ sender: UIButton) {
        if startFlag {
            removeCycleTimer()
            startFlag = false
            fetchData()
            print(luckyArr)
        }
    }
    func addLabel() {
        for _ in 0 ..< 20 {
            let label = UILabel()
            labelArr.append(label)
        }
    }
    func fetchData() {
        for _ in 0..<20 {
            luckyArr.append(arr.removeFirst())
        }
        
    }
}
extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
