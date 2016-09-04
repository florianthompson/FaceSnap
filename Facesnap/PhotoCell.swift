//
//  PhotoCell.swift
//  Facesnap
//
//  Created by Florian Thompson on 04/09/16.
//  Copyright © 2016 Florian Thompson. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "\(PhotoCell.self)"
    
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        imageView.contentMode = .ScaleAspectFit
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            imageView.leftAnchor.constraintEqualToAnchor(contentView.leftAnchor),
            imageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
            imageView.rightAnchor.constraintEqualToAnchor(contentView.rightAnchor),
            imageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor)
        ])
    }

}
