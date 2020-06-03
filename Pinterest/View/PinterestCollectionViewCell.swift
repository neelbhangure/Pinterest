//
//  PinterestCollectionViewCell.swift
//  Pinterest
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import UIKit

class PinterestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    /// updates the view when each time property value is set
    var imageDetails : ImageData? {
        didSet {
            descriptionLabel.text = imageDetails?.url.description
            imageView.image = nil
            imageView.loadImageUsingCache(withUrl: imageDetails?.downloadURL ?? "")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
