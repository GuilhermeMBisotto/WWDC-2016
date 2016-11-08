//
//  ExperiencesViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/27/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import CoreData

class ExperiencesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var companies = [NSManagedObject]()
    var apps = [NSManagedObject]()
    var skills = [NSManagedObject]()
    var headers = ["Professional xp",
                   "Portfolio",
                   "Tech Skills"]

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadFromCoreData("Company") { 
            self.loadFromCoreData("Apps", completion: { 
                self.loadFromCoreData("Skill", completion: { 
                    self.tableview.reloadData()
                })
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "gotoApp") {
            if let destination = segue.destinationViewController as? AppDetailViewController {
                destination.app = sender as! Apps
            }
        }
    }
    
    func loadFromCoreData(entityName: String, completion: () -> Void) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            if entityName == "Company" {
                companies = results as! [Company]
            } else if entityName == "Apps" {
                apps = results as! [Apps]
            } else {
                skills = results as! [Skill]
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        completion()
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.headers[section]
        case 1:
            return self.headers[section]
        default:
            return self.headers[section]
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return self.companies.count
            default:
                return 1
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("CompanyCell", forIndexPath: indexPath) as! ExperiencesCompaniesTableViewCell
            
            let company = companies[indexPath.row] as! Company
            
            cell.labelCompanyName.text = company.companyName
            cell.labelFunctionInCompany.text = company.function
            cell.labelTimeInCompany.text = company.timeInCompany
            cell.textviewDesc.text = company.desc
            
            cell.textviewDesc.contentOffset = CGPointMake(0, -20)
            cell.textviewDesc.showsVerticalScrollIndicator = true
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("AppCell", forIndexPath: indexPath) as! ExperiencesAppsTableViewCell
                        
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("SkillCell", forIndexPath: indexPath) as! ExperiencesSkillTableViewCell
            
            var textSkill: String = ""
            
            for skill: Skill in self.skills as! [Skill]{
                if textSkill == "" {
                    textSkill += "\(skill.skillName!)"
                } else {
                    textSkill += ", \(skill.skillName!)"
                }
            }
            
            cell.textview.text = textSkill
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? ExperiencesAppsTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row - indexPath.section)
    }
}

extension ExperiencesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AppCellItem", forIndexPath: indexPath) as! AppItemCollectionViewCell
        
        let app = apps[indexPath.item] as! Apps
        
        cell.appID = app.appID as! Int
        cell.labelNameApp.text = app.appName! as String
        cell.imageApp.image = UIImage(named: app.appName!)
        cell.imageApp.layer.cornerRadius = cell.imageApp.bounds.width/4
        cell.imageApp.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let app = apps[indexPath.item] as! Apps
        self.performSegueWithIdentifier("gotoApp", sender: app)
    }
}
