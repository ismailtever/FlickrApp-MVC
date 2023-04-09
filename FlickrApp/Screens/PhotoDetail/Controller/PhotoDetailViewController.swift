//
//  PhotoDetailViewController.swift
//  FlickrApp
//
//  Created by Ismail Tever on 7.04.2023.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var pdetailImageView: UIImageView!
    @IBOutlet weak var pownerImageView: UIImageView!
    @IBOutlet weak var pownerNameLabel: UILabel!
    @IBOutlet weak var pdescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = photo?.title
        pdetailImageView.backgroundColor = .darkGray
        pownerImageView.backgroundColor = .gray
        pownerNameLabel.text = "Owner Name"
        pdescriptionLabel.text = "Desctiption Label Desctiption Label Desctiption Label Desctiption Label Desctiption Label Desctiption Label"
        
        pownerNameLabel.text = photo?.ownername
        pdescriptionLabel.text = photo?.description?.content
        pownerImageView.layer.cornerRadius = 24.0
        
        NetworkManager.shared.fetchImages(with: photo?.urlZ) { data in
            self.pdetailImageView.image = UIImage(data: data)
        }
        NetworkManager.shared.fetchImages(with: photo?.buddyIconURL) { data in
            self.pownerImageView.image = UIImage(data: data)
        }
    }
    
    

 

}
