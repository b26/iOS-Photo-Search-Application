//
//  PhotoViewController.swift
//  PhotosApp
//
//  Created by Bashir on 2015-08-20.
//  Copyright © 2015 b26. All rights reserved.
//

import UIKit
import Haneke

class PhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var url:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setImage(self.url)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage(urlString: String) {
        let url = NSURL(string: urlString)
        self.imageView.hnk_setImageFromURL(url!)
    }

    @IBAction func saveButton(sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
    }
}
