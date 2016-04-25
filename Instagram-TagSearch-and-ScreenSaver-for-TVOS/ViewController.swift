//
//  ViewController.swift
//  tvOSTestapp
//
//  Created by Gwion Rhys Davies on 11/10/2015.
//  Copyright © 2015 GwiTek. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    var detailViewBlur:UIVisualEffectView!
    var detailView:UIView!
    
    var imagesArray = [InstagramObject]()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collectionView = resultsCollectionView else { return }
        
        /*
         Add a gradient mask to the collection view. This will fade out the
         contents of the collection view as it scrolls beneath the transparent
         navigation bar.
         */
        collectionView.maskView = GradientMaskView(frame: CGRect(origin: collectionView.bounds.origin, size: collectionView.bounds.size))
        self.SearchTag(searchField.text!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let collectionView = resultsCollectionView, maskView = collectionView.maskView as? GradientMaskView else { return }
        
        /*
         Update the mask view to have fully faded out any collection view
         content above the navigation bar's label.
         */
        maskView.maskPosition.end =  0
        /*
         Update the position from where the collection view's content should
         start to fade out. The size of the fade increases as the collection
         view scrolls to a maximum of half the navigation bar's height.
         */
        maskView.maskPosition.start = maskView.maskPosition.end + 50
        /*
         Position the mask view so that it is always fills the visible area of
         the collection view.
         */
        maskView.frame = CGRect(origin: CGPoint(x: collectionView.bounds.origin.x, y: collectionView.bounds.origin.y), size: collectionView.bounds.size)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SlideShow" {
            let toVC:SlideShowViewController = segue.destinationViewController as! SlideShowViewController
            toVC.imagesArray = self.imagesArray
        }
    }
    
    
    // MARK: View Logic Functions.
    
    @IBAction func Search(){
        self.SearchTag(self.searchField.text!)
    }
    
    func SearchTag(tag:String) {
        
        let instagramURLString = "https://api.instagram.com/v1/tags/\(tag)/media/recent?client_id=\(instagramClientID)"
        
        let manager = AFHTTPSessionManager()
        
        manager.GET(instagramURLString, parameters: nil, success: { (NSURLSessionDataTask, responseObject) -> Void in
            if let dataArray = responseObject!.valueForKey("data") as? [AnyObject] {
                self.imagesArray = []
                for i in 0 ..< dataArray.count {
                    let dataObject: AnyObject = dataArray[i]
                    let instagramObject:InstagramObject = InstagramObject(data: dataObject)
                    self.imagesArray.append(instagramObject)
                }
                self.resultsCollectionView.reloadData()
            }
            },
                    failure: {(NSURLSessionDataTask, error) -> Void in
                        print(error.description)
        })
    }
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        if(presses.first?.type == UIPressType.Menu) {
            // handle event
            if detailViewBlur != nil {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.detailViewBlur.alpha = 0
                    }, completion: { (Bool) -> Void in
                        self.detailViewBlur.removeFromSuperview()
                        self.detailViewBlur = nil
                })
            } else {
                super.pressesEnded(presses, withEvent: event)
            }
        } else if (presses.first?.type == UIPressType.PlayPause){
            self.performSegueWithIdentifier("SlideShow", sender: nil)
        }
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        
    }
    
    
    // MARK: Collection View Delegate Functions.
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        viewDidLayoutSubviews()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // The collection view shows all items in a single section.
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
        cell.instagramObject = self.imagesArray[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let instaObject:InstagramObject = (collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCell).instagramObject
        detailViewBlur = UIVisualEffectView(frame: self.view.frame)
        detailViewBlur.effect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        detailViewBlur.alpha = 0
        self.view.addSubview(detailViewBlur)
        self.view.bringSubviewToFront(detailViewBlur)
        detailView = DetailView(instagramObject: instaObject, frame: CGRect(x: (self.view.frame.width/2)-450, y: (self.view.frame.height/2-300), width: 900, height: 600))
        detailViewBlur.addSubview(detailView)
        self.view.bringSubviewToFront(detailView)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.detailViewBlur.alpha = 1
        }
    }
}

