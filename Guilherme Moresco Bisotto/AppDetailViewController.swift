//
//  AppDetailViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/27/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class AppDetailViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIDocumentInteractionControllerDelegate {

    var app: Apps!
    var photos: [String]!
    var rotate:  Bool = false
    
    @IBOutlet var imageApp: UIImageView!
    @IBOutlet var labelAppName: UILabel!
    @IBOutlet var labelMyFunction: UILabel!
    @IBOutlet var texviewAppDesc: UITextView!
    @IBOutlet var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageApp.image = UIImage(named: self.app.appName!)
        self.imageApp.layer.cornerRadius = self.imageApp.bounds.width/4
        self.imageApp.layer.masksToBounds = true
        self.labelAppName.text = app.appName
        self.labelMyFunction.text = app.function
        self.texviewAppDesc.text = app.desc
        self.texviewAppDesc.contentOffset = CGPointMake(0, -220)
        
        self.photos = []

        if self.app.appID?.intValue == 0 {
            for i in 0 ... 12 {
                self.photos.append("\(self.app.appPrefixImgName!)\(i).png")
            }
        } else if self.app.appID?.intValue == 1 {
            for i in 0 ... 4 {
                self.photos.append("\(self.app.appPrefixImgName!)\(i).jpg")
            }
        } else {
            for i in 0 ... 2 {
                self.photos.append("\(self.app.appPrefixImgName!)\(i).jpg")
            }
        }
        
        self.collectionview.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.rotate = false
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        supportedInterfaceOrientations()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if self.rotate {
            return UIInterfaceOrientationMask.AllButUpsideDown
        }
        return UIInterfaceOrientationMask.Portrait
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AppDetailCell", forIndexPath: indexPath) as! AppDetailCollectionViewCell
        
        cell.imageAppPhoto.image = UIImage(named: photos[indexPath.item])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let photo = photos[indexPath.item]
        if let resourcePath = NSBundle.mainBundle().pathForResource(photo, ofType: "") {
            previewDocumentAtPath(resourcePath)
        }
    }
    
    //MARK: - UIDocumentInteractionController Delegate
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        if let navigationController = self.navigationController {
            return navigationController
        } else {
            return self
        }
    }
    
    func documentInteractionControllerViewForPreview(controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }
    
    func documentInteractionControllerRectForPreview(controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
    
    func previewDocumentAtPath(filePath: String) {
        
        let fileUrl: NSURL = NSURL(fileURLWithPath: filePath)
        let interactionController: UIDocumentInteractionController = UIDocumentInteractionController(URL: fileUrl)
        interactionController.name = ""
        interactionController.delegate = self
        
        if interactionController.presentPreviewAnimated(true) {
            self.rotate = true
            supportedInterfaceOrientations()
        }
        
    }
}
