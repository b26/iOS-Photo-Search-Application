//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by Bashir on 2015-08-12.
//  Copyright © 2015 b26. All rights reserved.
//

import UIKit
import Haneke

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sourceImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var url: String? {
        didSet {
            setImage(url!)
        }
    }
    
    var source: String? {
        
        didSet {
            self.sourceImage.layer.cornerRadius = self.sourceImage.frame.height / 2
            self.sourceImage.clipsToBounds = true
            
            switch(source!) {
            case "flickr":
                self.sourceImage.image = UIImage(named: "flickr")
            case "tumblr":
                self.sourceImage.image = UIImage(named: "tumblr")
            default:
                print("error in source switch statement")
            }
        }

    }
    
    var title: String? {
        didSet {
            self.titleLabel.text = title!
        }
    }
    
    

    
    func setImage(url: String) {
        let imageUrl = NSURL(string: url)
        self.imageView.hnk_setImageFromURL(imageUrl!, placeholder: UIImage(named: "placeholder"), format: Format<UIImage>(name: "image"), failure: { (error) -> () in
            }) { (image) -> () in
                self.imageView.image = image
        }
    }
}
