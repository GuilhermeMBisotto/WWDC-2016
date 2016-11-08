//
//  GlanceController.swift
//  Guilherme Moresco Bisotto WatchKit Extension
//
//  Created by Guilherme Moresco Bisotto on 4/21/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet var labelDaysLeft: WKInterfaceLabel!
    @IBOutlet var imageIcon: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let eventDateAsString: String = "12 Jun 2016 09:00:00"
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        let eventDate = dateFormatter.dateFromString(eventDateAsString)!
        let currentDate = NSDate()
        
        let cal = NSCalendar.currentCalendar()
        let components = cal.components(.Day, fromDate: currentDate, toDate: eventDate, options: NSCalendarOptions.MatchFirst)
        
        labelDaysLeft.setText("\(components.day)")

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
