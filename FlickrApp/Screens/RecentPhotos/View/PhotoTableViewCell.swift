//
//  PhotoTableViewCell.swift
//  FlickrApp
//
//  Created by Ismail Tever on 7.04.2023.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ownerImageView.layer.cornerRadius = 24.0 // 48 in yarısı bundan tam yuvarlak olucak
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
