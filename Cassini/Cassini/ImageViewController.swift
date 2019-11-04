//
//  ImageViewController.swift
//  Cassini
//
//  Created by Sunny on 2019/7/10.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    private var image: UIImage? {
        get{
            return imageVIew.image
        }set{
            imageVIew.image = newValue
            imageVIew.sizeToFit()
            scrollView?.contentSize = imageVIew.frame.size
            spinner?.stopAnimating()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageVIew.image == nil {
            fetchImage()
        }
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageVIew)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageVIew
    }
    var imageVIew = UIImageView()
   
    func fetchImage () {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self?.imageURL {
                        self?.image = UIImage(data: imageData)
                    }
                }
               
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = DemoURL.stanford
//        }
    }
}
