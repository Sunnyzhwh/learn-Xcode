//
//  starViewController.swift
//  view
//
//  Created by Sunny on 2019/9/27.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class starViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? imageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, let url = demoURL.superstar[identifier], let vc = segue.destination.contents as? imageViewController {
            vc.imageURL = url
            vc.title = (sender as? UIButton)?.currentTitle
        }
    }
   

}
extension UIViewController{
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }else{
            return self
        }
    }
}
