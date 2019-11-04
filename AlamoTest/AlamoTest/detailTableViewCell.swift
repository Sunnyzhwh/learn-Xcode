//
//  detailTableViewCell.swift
//  Alamotest
//
//  Created by Sunny on 2019/10/8.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
import Kingfisher
class detailTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var replylabel: UILabel!
    
    @IBOutlet weak var sourcelabel: UILabel!
    
    var newsM: NewsModel?{
        didSet{
            self.titlelabel.text = newsM?.title
            self.replylabel.text = "\(newsM?.replyCount ?? 0)跟帖"
            self.sourcelabel.text = newsM?.source
            let imgURL = URL(string: newsM?.imgsrc ?? "")
            imageview.kf.setImage(with: imgURL)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        replylabel.layer.cornerRadius = 4
        replylabel.layer.masksToBounds = true
       
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.layer.cornerRadius = 8
        imageview.layer.masksToBounds = true
        imageview.layer.shadowRadius = 8
        imageview.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageview.layer.shadowOpacity = 1
        imageview.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageview.layer.shouldRasterize = true
        imageview.layer.rasterizationScale = UIScreen.main.scale
    }
}
