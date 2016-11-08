//
//  ALittleMoreViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/25/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import CoreData

class ALittleMoreViewController: BaseViewController {

    var person = [NSManagedObject]()
    
    @IBOutlet var buttonClose: UIButton!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var labelText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        labelText.text = person[0].valueForKey("aLittleMore") as! String!
        self.buttonClose.alpha = 0.0
        
        view.backgroundColor = UIColor.clearColor()
        
        labelText.contentOffset = CGPointMake(0, -220)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let maskPath = UIBezierPath(roundedRect: self.buttonClose.bounds, byRoundingCorners: [UIRectCorner.BottomRight , UIRectCorner.BottomLeft], cornerRadii: CGSizeMake(20.0, 20.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.buttonClose.bounds
        maskLayer.path = maskPath.CGPath
        self.buttonClose.layer.mask = maskLayer
        
        UIView.animateWithDuration(0.3) {
            self.buttonClose.alpha = 1.0
            self.viewBack.alpha = 0.8
        }
    }

    @IBAction func closeView(sender: AnyObject) {
        
        UIView.animateWithDuration(0.3, animations: { 
            self.viewBack.alpha = 0.0
            self.buttonClose.alpha = 0.0
            }) { (finish) in
                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
