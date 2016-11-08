//
//  HomeViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/19/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //---multipliers to convert to seconds---
    let MINUTE: NSTimeInterval = 60
    let HOUR: NSTimeInterval = 60 * 60
    let DAY: NSTimeInterval = 24 * 3600

    
    let collectionColor = [UIColor(red: 153/255.0, green: 204/255.0, blue: 114/255.0, alpha: 1.0),
                           UIColor(red: 186/255.0, green: 58/255.0, blue: 156/255.0, alpha: 1.0),
                           UIColor(red: 216/255.0, green: 151/255.0, blue: 104/255.0, alpha: 1.0),
                           UIColor(red: 223/255.0, green: 64/255.0, blue: 63/255.0, alpha: 1.0),
                           UIColor(red: 0/255.0, green: 175/255.0, blue: 168/255.0, alpha: 1.0)]
    
    let collectionIcons = [UIImage(named: "my-photo"),
                           UIImage(named: "tour"),
                           UIImage(named: "education"),
                           UIImage(named: "experiences"),
                           UIImage(named: "watch-icon")]
    
    let collectionTitles = ["How am I?",
                            "WWDC 15 and USA Tour",
                            "Education",
                            "Experiences, Skills and Portfolio",
                            "WWDC 2016 Countdown"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView.init(image: UIImage(named: "wwdc16-logo"))
    }
    
    //MARK: - UICollectionView Delegate and DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            default:
                return 4
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("homeCell", forIndexPath: indexPath) as! HomeCollectionViewCell
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("homeProfileCell", forIndexPath: indexPath) as! HomeCollectionViewCell
            cell.imageHomeCell.layer.cornerRadius = 20
            cell.imageHomeCell.layer.masksToBounds = true
        }
        
        cell.imageHomeCell.image = collectionIcons[indexPath.row + indexPath.section]
        cell.labelHomeCell.textColor = collectionColor[indexPath.row + indexPath.section]
        cell.labelHomeCell.text = collectionTitles[indexPath.row + indexPath.section]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {

        return indexPath.section == 0 ? CGSize(width: collectionView.frame.width, height: collectionView.frame.width/2-1) : CGSize(width: collectionView.frame.width/2-0.5, height: collectionView.frame.width/2-1)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = UIViewController()
        
        if indexPath.section == 0 {
            viewController = storyboard.instantiateViewControllerWithIdentifier("ProfileID") as! ProfileViewController
        } else {
            switch indexPath.row {
                case 0:
                    viewController = storyboard.instantiateViewControllerWithIdentifier("MapTourID") as! MapViewController
                case 1:
                    viewController = storyboard.instantiateViewControllerWithIdentifier("EducationID") as! EducationViewController
                case 2:
                    viewController = storyboard.instantiateViewControllerWithIdentifier("ExperiencesID") as! ExperiencesViewController
                default:
                    viewController = storyboard.instantiateViewControllerWithIdentifier("CountdownID") as! CountdownViewController
            }
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
