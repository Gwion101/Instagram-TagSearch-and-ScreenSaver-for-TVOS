//
//  instagramObject.swift
//  Photo Search Example with UICollectionView
//
//  Created by Gwion Rhys Davies on 13/10/2015.
//  Copyright © 2015 Thinkful. All rights reserved.
//

import UIKit

class InstagramObject: NSObject {
    
    var image:UIImage!
    var objectData:AnyObject?
    var caption = ""
    var userID = ""
    var userName = ""
    var userAvatar:UIImage!
    
    init(data:AnyObject) {
        objectData = data
        let imageURL = NSURL(string: (data.valueForKeyPath("images.standard_resolution.url") as! String))
        image = UIImage(data: NSData(contentsOfURL: imageURL!)!)!
        let avatarURL = NSURL(string: (data.valueForKeyPath("user.profile_picture") as! String))
        userAvatar = UIImage(data: NSData(contentsOfURL: avatarURL!)!)!
        caption = data.valueForKeyPath("caption.text") as! String
        userID = data.valueForKeyPath("user.id") as! String
        userName = data.valueForKeyPath("user.username") as! String
    }
}
