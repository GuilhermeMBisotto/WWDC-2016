//
//  CountdownViewController.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/25/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class CountdownViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let watches = [UIImage(named: "watch-black-in-app"),
                   UIImage(named: "watch-black-complication-1"),
                   UIImage(named: "watch-black-complication-2"),
                   UIImage(named: "watch-black-glance")]
    
    let texts = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CountdownCell", forIndexPath: indexPath) as! CountdownTableViewCell
        
        cell.imagePhoto.image = watches[indexPath.row]
        
        return cell
    }
}
