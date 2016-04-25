//
//  detailView.swift
//  SplashTV
//
//  Created by Gwion Rhys Davies on 13/10/2015.
//  Copyright © 2015 GwiTek. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var username: UILabel!
    
    var instagramObject:InstagramObject!
    
    init(instagramObject:InstagramObject, frame:CGRect){
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("detailView", owner: self, options: nil)
        self.instagramObject = instagramObject
        image.image = instagramObject.image
        caption.text = instagramObject.caption
        username.text = instagramObject.userName
        userAvatar.image = instagramObject.userAvatar
        caption.sizeToFit()
        self.addSubview(self.view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
