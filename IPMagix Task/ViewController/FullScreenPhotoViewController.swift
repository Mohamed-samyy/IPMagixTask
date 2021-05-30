//
//  FullScreenPhotoViewController.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    var imageURL = ""
    var imageTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.setKFImage(imageUrl: imageURL)
        self.title = imageTitle
        photo.backgroundColor = photo.image?.averageColor
    }
    

}
