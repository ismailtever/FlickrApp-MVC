//
//  PhotoDetailViewController.swift
//  FlickrApp
//
//  Created by Ismail Tever on 7.04.2023.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var pdetailImageView: UIImageView!
    @IBOutlet weak var pownerImageView: UIImageView!
    @IBOutlet weak var pownerNameLabel: UILabel!
    @IBOutlet weak var pdescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photo Detail"
        pdetailImageView.backgroundColor = .darkGray
        pownerImageView.backgroundColor = .gray
        pownerNameLabel.text = "Owner Name"
        pdescriptionLabel.text = "Desctiption Label Desctiption Label Desctiption Label Desctiption Label Desctiption Label Desctiption Label"
    }
    

 

}
