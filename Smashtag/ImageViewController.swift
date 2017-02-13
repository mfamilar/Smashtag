//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/13/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    private var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 1.5
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.sizeToFit()
        scrollView?.contentSize = imageView.frame.size
        scrollView.addSubview(imageView)
    }
}
