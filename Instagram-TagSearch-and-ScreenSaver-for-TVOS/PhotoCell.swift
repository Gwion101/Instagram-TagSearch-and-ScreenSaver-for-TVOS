//
//  PhotoCell.swift
//  Photo Search Example with UICollectionView
//
//  Created by 262Hz on 10/22/14.
//  Copyright (c) 2014 Thinkful. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    var instagramObject:InstagramObject! {
        didSet {
            userLabel.text = instagramObject.userName
            photoImageView.image = instagramObject.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.adjustsImageWhenAncestorFocused = true
        photoImageView.clipsToBounds = false
        
        userLabel.layer.shadowColor = UIColor.blackColor().CGColor
        userLabel.layer.shadowRadius = 5
        userLabel.layer.shadowOpacity = 1
        userLabel.layer.shadowOffset = CGSizeZero
        userLabel.layer.masksToBounds = false
        userLabel.alpha = 0.0
        
        
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        /*
        Update the label's alpha value using the `UIFocusAnimationCoordinator`.
        This will ensure all animations run alongside each other when the focus
        changes.
        */
        coordinator.addCoordinatedAnimations({ [unowned self] in
            if self.focused {
                self.userLabel.alpha = 1.0
            }
            else {
                self.userLabel.alpha = 0.0
            }
            }, completion: nil)
    }
    
}
