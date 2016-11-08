//
//  EducationViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/27/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit
import CoreData

class EducationViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    var institutions = [NSManagedObject]()
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadFromCoreData {
            self.tableview.reloadData()
        }
    }

    func loadFromCoreData(completion: () -> Void) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Institution")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            institutions = results as! [Institution]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        completion()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return institutions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EducationCell", forIndexPath: indexPath) as! EducationTableViewCell
        
        let inst = institutions[indexPath.row] as! Institution
        
        cell.lableLocal.text = inst.instName
        cell.labelType.text = inst.info
        cell.labelTime.text = inst.period
        
        return cell
    }
}
