//
//  MyCollectionViewCell.swift
//  LazyLoading WebApi collectionView
//
//  Created by NTS on 01/02/24.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var jsonImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.jsonImageView.image = UIImage(named: "1")
    }
}
