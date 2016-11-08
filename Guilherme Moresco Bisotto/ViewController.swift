//
//  ViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/19/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import CoreData

class ViewController: BaseViewController {
    
    private var apps = []
    private var companies = []
    private var skills = []
    private var institutions = []
    private var person = []
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var constLeadingTitle: NSLayoutConstraint!
    @IBOutlet weak var constLeadingName: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apps = loadJson("apps")
        companies = loadJson("companies")
        skills = loadJson("skills")
        institutions = loadJson("institutions")
        person = loadJson("person")
        
        //If first launch, setting NSUserDefault and CoreData.
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if !firstLaunch  {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            saveApps()
            saveCompanies()
            saveSkills()
            saveInstitutions()
            savePerson()
        }

        
        self.scrollview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let screenRect: CGRect =  UIScreen.mainScreen().bounds
        let screenWidth: CGFloat = screenRect.size.width
        
        self.scrollview.alpha = 0.0
        self.constLeadingTitle.constant = view.frame.width/2 - self.labelTitle.frame.width/2
        self.constLeadingName.constant = view.frame.width/2 - self.labelTitle.frame.width/2
        view.layoutIfNeeded()
        
        UIView.animateWithDuration (0.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut ,animations: {
            self.scrollview.setContentOffset(CGPointMake(0, 0), animated: false)
            }, completion: { _ in
                UIView.animateWithDuration (3.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut ,animations: {
                    self.scrollview.alpha = 1.0
                    self.scrollview.setContentOffset(CGPointMake(2000-screenWidth, 0), animated: false)
                    self.constLeadingTitle.constant = self.scrollview.contentOffset.x + 16
                    self.constLeadingName.constant = self.scrollview.contentOffset.x + 32
                    self.view.layoutIfNeeded()
                    }, completion: { _ in
                        UIView.animateWithDuration(1.0, animations: {
                            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            var viewController = UIViewController()
                            
                            viewController = storyboard.instantiateViewControllerWithIdentifier("NavigationID") as! NavigationViewController
                            
                            self.presentViewController(viewController, animated: true, completion: nil)
                        })
                })
        })
    }
    
    //MARK: - Core Data
    //Save apps objects in CoreData to use in app
    func saveApps() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for appItem in apps {
            
            let entity =  NSEntityDescription.entityForName("Apps", inManagedObjectContext:managedContext)
            let app = Apps(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            app.appName = appItem.valueForKey("appName") as! String!
            app.appIcon = appItem.valueForKey("appIcon") as! String!
            app.appPrefixImgName = appItem.valueForKey("appPrefixImgName") as! String!
            app.appID = appItem.valueForKey("appID") as! NSNumber!
            app.desc = appItem.valueForKey("appDesc") as! String!
            app.function = appItem.valueForKey("function") as! String!
            
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    //Save companies objects in CoreData to use in app
    func saveCompanies() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for companyItem in companies {
            
            let entity =  NSEntityDescription.entityForName("Company", inManagedObjectContext:managedContext)
            let company = Company(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            company.companyName = companyItem.valueForKey("companyName") as! String!
            company.companyID = companyItem.valueForKey("companyID") as! NSNumber!
            company.timeInCompany = companyItem.valueForKey("timeInCompany") as! String!
            company.function = companyItem.valueForKey("function") as! String!
            company.desc = companyItem.valueForKey("desc") as! String!
            
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    //Save companies objects in CoreData to use in app
    func saveSkills() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for skillItem in skills {
            
            let entity =  NSEntityDescription.entityForName("Skill", inManagedObjectContext:managedContext)
            let skill = Skill(entity: entity!, insertIntoManagedObjectContext: managedContext)

            skill.skillName = skillItem.valueForKey("skillName") as! String!
            
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    //Save institutions objects in CoreData to use in app
    func saveInstitutions() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for instItem in institutions {
            
            let entity =  NSEntityDescription.entityForName("Institution", inManagedObjectContext:managedContext)
            let inst = Institution(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            inst.instName = instItem.valueForKey("instName") as! String!
            inst.info = instItem.valueForKey("info") as! String!
            inst.period = instItem.valueForKey("period") as! String!
            
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    //Save my profile object in CoreData to use in app
    func savePerson() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for personItem in person {
            
            let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext:managedContext)
            let person = Person(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            person.aLittleMore = personItem.valueForKey("aLittleMore") as! String!
            person.born = personItem.valueForKey("born") as! String!
            person.email = personItem.valueForKey("email") as! String!
            person.jobs = personItem.valueForKey("jobs") as! String!
            person.linkFacebook = personItem.valueForKey("linkFacebook") as! String!
            person.linkGithub = personItem.valueForKey("linkGithub") as! String!
            person.linkLinkedin = personItem.valueForKey("linkLinkedin") as! String!
            person.locationName = personItem.valueForKey("locationName") as! String!
            person.cellPhone = personItem.valueForKey("cellPhone") as! String!
            
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }

    
    //MARK: - JSON
    func loadJson(jsonFileName: String) -> NSArray {
        
        if let path = NSBundle.mainBundle().pathForResource(jsonFileName, ofType: "json") {
            let url :NSURL = NSURL.fileURLWithPath(path)
            if let data = NSData(contentsOfURL: url) {
                do {
                    return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        }
        return []
    }
}

