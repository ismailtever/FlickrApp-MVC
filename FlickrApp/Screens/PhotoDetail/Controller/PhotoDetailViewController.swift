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
        
        fetchImages(with: photo?.urlZ) { data in
            self.pdetailImageView.image = UIImage(data: data)
        }
        if let iconServer = photo?.iconserver,
           let iconFarm = photo?.iconfarm,
           let nsId = photo?.owner,
           NSString(string: iconServer).intValue > 0 {
            fetchImages(with: "http://farm\(iconFarm).staticflickr.com/\(iconServer)/buddyicons/\(nsId).jpg") { data in
                self.pownerImageView.image = UIImage(data: data)
            }
        } else {
            fetchImages(with: "https://www.flickr.com/images/buddyicon.gif") { data in
                self.pownerImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func fetchImages(with url: String?, completion: @escaping (Data) -> Void) {
        if let urlString = url, let url = URL(string: urlString) { //N düşük çözünürlüklü olduğunda N yi aldık.
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    debugPrint(error)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
//                        cell.photoImageView.image = UIImage(data: data)
                        completion(data)
                    }
                }
            }.resume()
        }
    }

 

}
