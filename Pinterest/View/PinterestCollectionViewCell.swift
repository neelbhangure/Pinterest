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
    var imageDetails : ImageData? {
        didSet {
            imageView.image = nil
            imageView.loadImageUsingCache(withUrl: imageDetails?.downloadURL ?? "")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
