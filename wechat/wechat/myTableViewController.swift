//
//  myTableViewController.swift
//  wechat
//
//  Created by Sunny on 2019/9/25.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero) //去掉多余的空白行
    }

    // MARK: - Table view data source
    var captial = ["北京" : "icon01","上海" : "icon02","广州" : "icon03","深圳" : "icon04"]
    var mydata = UserData()
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return captial.count
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)

        // Configure the cell...
        let rect1 = CGPoint(x: 90, y: 20)
        let rect2 = CGRect(x: 60, y: 40, width: 200, height: 6)
        let show = UILabel()
        let detail = UILabel()
        show.text = mydata.data[indexPath.row].0
        show.sizeToFit()
        show.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        show.center = rect1
        detail.text = mydata.data[indexPath.row].1
        detail.sizeToFit()
        detail.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        detail.textAlignment = .left
        detail.frame = rect2
        let imageString = mydata.data[indexPath.row].2
        if let img = UIImage(named: imageString){
            let iv = UIImageView(image: img)
            iv.frame = CGRect(x: 5.0, y: 5.0, width: 50.0, height: 50.0)
            iv.layer.cornerRadius = 10.0
            iv.layer.masksToBounds = true
            cell.addSubview(iv)
        }
        
        cell.addSubview(show)
        cell.addSubview(detail)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0) // 设置cell分割线的长度
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cell" {
            _ = segue.destination as? ImageViewController
        }
            
        
    }
}
