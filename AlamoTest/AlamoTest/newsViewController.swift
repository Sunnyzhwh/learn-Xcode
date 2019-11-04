//
//  newsViewController.swift
//  Alamotest
//
//  Created by Sunny on 2019/10/7.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class newsViewController: UIViewController {
    lazy var newsModel: [NewsModel] = [NewsModel]()
    private lazy var tableView: UITableView = { [unowned self] in
        let tbv = UITableView()
        tbv.frame = self.view.bounds
        tbv.dataSource = self
        tbv.delegate = self
        tbv.backgroundView = UIImageView(image: UIImage(named: "newsBG"))
//        tbv.register(UITableViewCell.self, forCellReuseIdentifier: "Tcell")
        tbv.register(UINib(nibName: "detailTableViewCell", bundle: nil), forCellReuseIdentifier: "Tcell")
        tbv.rowHeight = 90
        tbv.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tbv.separatorInset = UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 0)
        return tbv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        loadData()
        setNavigationBar()
        setTabBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.selectRow(at: nil, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
    }
    func setTabBar() {
        tabBarController?.tabBar.isTranslucent = false
    }
}
extension newsViewController{
    func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "BG"), for: UIBarMetrics.default)
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo_nav"))
        navigationItem.titleView?.contentMode = .scaleAspectFit
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .plain, target: self, action: #selector(searchItemClicked))
        navigationController?.navigationBar.isTranslucent = false
    }
    @objc func searchItemClicked() {
        print("---")
    }
}
extension newsViewController{
    func loadData() {
        Network.requestData(url: "http://c.m.163.com/nc/article/list/T1348649079062/0-20.html", type: .get) { (result) in
            guard let resultData = result as? [String : Any] else { return }
            guard let dataArray = resultData["T1348649079062"] as? [[String : Any]] else { return }
            for dict in dataArray {
                self.newsModel.append(NewsModel(dict: dict))
            }
            self.tableView.reloadData()
        }
    }
}
extension newsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tcell", for: indexPath) as! detailTableViewCell
        cell.newsM = newsModel[indexPath.row]
        cell.isOpaque = true
        return cell
    }
}
extension newsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---")
        let wvc = WebDetailViewController()
//        present(wvc, animated: true)
        wvc.newsD = newsModel[indexPath.row]
        navigationController?.pushViewController(wvc, animated: true)
    }
}
