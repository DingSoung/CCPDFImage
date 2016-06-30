//
//  ViewController.swift
//  DEMO
//
//  Created by Songwen Ding on 6/30/16.
//  Copyright © 2016 Songwen Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.imageView)
        
        CCPDFImage.instance.useRamCache = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.imageView.frame = self.view.bounds
        CCPDFImage.instance.asyncGetImage("Group", bundle: NSBundle.mainBundle(), page: 1, size: self.imageView.bounds.size) { [weak self](image) in
            self?.imageView.image = image
        }
        //self.imageView.image = CCPDFImage.instance.image("Group", bundle: NSBundle.mainBundle(), page: 1, size: self.imageView.bounds.size)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

