//
//  ProfileViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/19/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let animationWWDCWordsImages = ["wwdc-w",
                                            "wwdc-ww",
                                            "wwdc-d",
                                            "wwdc-c",
                                            "wwdc-1",
                                            "wwdc-6",
                                            "wwdc-apple-icon"]
    private var animationCont = 0
    private var person = [NSManagedObject]()
    
    @IBOutlet weak var viewAnimationContainer: UIView!
    @IBOutlet weak var imageMyPhoto: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageMyPhoto.layer.masksToBounds = true
        self.tableview.alpha = 0.0
        
        self.loadFromCoreData {
            UIView.animateWithDuration(0.3){
                self.tableview.alpha = 1.0
            }
        }
        
        //Timers for animations
        let timerWWDCAnimation = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(ProfileViewController.createWWDCWordsToAnimate), userInfo: nil, repeats: true)
        
        //Prevent timer does not stop when scrolling PageControl
        NSRunLoop.currentRunLoop().addTimer(timerWWDCAnimation, forMode: NSRunLoopCommonModes)
    }
    
    func loadFromCoreData(completion: () -> Void) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            person = results as! [Person]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        self.tableview.reloadData()
        
        completion()
    }
    
    func createWWDCWordsToAnimate() {
        let wwdcWord = UIView()
        let duration = 4.0
        let delay = 0.0
        let options = UIViewAnimationOptions.CurveLinear
        let size : CGFloat = CGFloat(20)
        let yPosition : CGFloat = -100
        let xPosition: CGFloat = CGFloat(animationCont*50+40)
        
        wwdcWord.frame = CGRect(x:  xPosition, y: yPosition, width: size, height: size)
        wwdcWord.layer.zPosition = 1.0
        
        let img = UIImageView()
        img.image = UIImage(named: animationWWDCWordsImages[Int(animationCont)])
        animationCont += 1
        if animationCont == animationWWDCWordsImages.count {
            animationCont = 0
        }
        img.frame = CGRectMake(0-size, yPosition, size, size)
        wwdcWord.addSubview(img)
        
        viewAnimationContainer.addSubview(wwdcWord)
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            wwdcWord.frame = CGRect(x: xPosition, y: self.view.frame.height+100, width: size, height: size)
            }, completion: { animationFinished in
                wwdcWord.removeFromSuperview()
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.person.count == 0 {
            return 0
        }
        
        switch section {
        case 0:
            return 4
        case 1:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let me: Person = person[0] as! Person

        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileComumCell", forIndexPath: indexPath) as! ProfileTableViewCell
            
            switch indexPath.row {
                case 0:
                    cell.labelItemTitle.text = "E-mail"
                    cell.labelItemDescription.text = me.email
                case 1:
                    cell.labelItemTitle.text = "Born In"
                    cell.labelItemDescription.text = me.born
                case 2:
                    cell.labelItemTitle.text = "Job"
                    cell.labelItemDescription.text = me.jobs
                default:
                    cell.labelItemTitle.text = "A Little More"
                    cell.labelItemDescription.text = me.aLittleMore
                    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileContactCell", forIndexPath: indexPath) as! ProfileContactTableViewCell
            
            switch indexPath.row {
                case 0:
                    cell.buttonContact.setTitle("LinkedIn", forState: UIControlState.Normal)
                    cell.url = me.linkLinkedin
                    cell.contactId = ProfileContactTableViewCell.CONTACT.LINKEDIN
                case 1:
                    cell.buttonContact.setTitle("Github", forState: UIControlState.Normal)
                    cell.url = me.linkGithub
                    cell.contactId = ProfileContactTableViewCell.CONTACT.GITHUB
                case 2:
                    cell.buttonContact.setTitle("Facebook", forState: UIControlState.Normal)
                    cell.url = me.linkFacebook
                    cell.contactId = ProfileContactTableViewCell.CONTACT.FACEBOOK
                case 3:
                    cell.buttonContact.setTitle("Call me", forState: UIControlState.Normal)
                    cell.url = me.cellPhone
                    cell.contactId = ProfileContactTableViewCell.CONTACT.CELLPHONE
                default:
                    cell.buttonContact.setTitle("Send me a E-mail", forState: UIControlState.Normal)
                    cell.url = me.email
                    cell.contactId = ProfileContactTableViewCell.CONTACT.EMAIL
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileMapCell", forIndexPath: indexPath) as! ProfileMapTableViewCell
            
            cell.labelLocation.text = me.locationName
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 2 ? 200 : 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var viewController = UIViewController()
            
            viewController = storyboard.instantiateViewControllerWithIdentifier("ALittleMoreID") as! ALittleMoreViewController
            
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
}
