//
//  SlideShowViewController.swift
//  SplashTV
//
//  Created by Gwion Rhys Davies on 16/10/2015.
//  Copyright © 2015 GwiTek. All rights reserved.
//

import UIKit

class SlideShowViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    
    var currentInstagramObject:InstagramObject!
    var imagesArray:[InstagramObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image2.alpha=0
        currentInstagramObject = imagesArray[0]
        play()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func play(){
        if imagesArray.indexOf(currentInstagramObject)!+1 == imagesArray.count {
            currentInstagramObject = imagesArray[0]
        } else {
            currentInstagramObject = imagesArray[imagesArray.indexOf(currentInstagramObject)!+1]
        }
        image2.image = currentInstagramObject.image
        UIView.animateWithDuration(5, animations: { () -> Void in
            self.image2.alpha=1
            self.image1.alpha=0
            }) { (bool) -> Void in
                self.image1.image = self.image2.image
                self.image1.alpha=1
                self.image2.alpha=0
                dispatch_async(dispatch_get_main_queue()) {
                    self.play()
                }
        }
    }
}
