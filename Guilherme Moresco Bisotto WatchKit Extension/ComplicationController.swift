//
//  ComplicationController.swift
//  Guilherme Moresco Bisotto WatchKit Extension
//
//  Created by Guilherme Moresco Bisotto on 4/21/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        
        
        let eventDateAsString: String = "12 Jun 2016 09:00:00"
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        let eventDate = dateFormatter.dateFromString(eventDateAsString)!
        let currentDate = NSDate()
        
        let cal = NSCalendar.currentCalendar()
        let components = cal.components(.Day, fromDate: currentDate, toDate: eventDate, options: NSCalendarOptions.MatchFirst)
        
        var template: CLKComplicationTemplate?
        
        switch complication.family {
        case .ModularSmall:
            let modularSmallTemplate = CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "\(components.day)")
            modularSmallTemplate.fillFraction = 1.0
            modularSmallTemplate.ringStyle = CLKComplicationRingStyle.Closed
            template = modularSmallTemplate
            
        case .ModularLarge:
            let modularLargeTemplate = CLKComplicationTemplateModularLargeTallBody()
            modularLargeTemplate.headerTextProvider = CLKSimpleTextProvider(text: "WWDC 2016", shortText: "WWDC16")
            modularLargeTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "\(components.day) days left", shortText: "Left: \(components.day)D")
            template = modularLargeTemplate
            
        case .UtilitarianSmall:
            let utilitarianSmal = CLKComplicationTemplateUtilitarianSmallFlat()
            utilitarianSmal.textProvider = CLKSimpleTextProvider(text: "Days: \(components.day)", shortText: "\(components.day)")
            template = utilitarianSmal
            
        case .UtilitarianLarge:
            let utilitarianLarge = CLKComplicationTemplateUtilitarianLargeFlat()
            utilitarianLarge.textProvider = CLKSimpleTextProvider(text: "WWDC16: \(components.day)d \(components.hour):\(components.minute):\(components.second)", shortText: "WWDC16: \(components.day) days")
            template = utilitarianLarge
            
        case .CircularSmall:
            let circularSmallTemplate = CLKComplicationTemplateCircularSmallRingText()
            circularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "\(components.day)")
            circularSmallTemplate.fillFraction = 0.25
            circularSmallTemplate.ringStyle = CLKComplicationRingStyle.Closed
            template = circularSmallTemplate
        }
        
        
        let timeEntry: CLKComplicationTimelineEntry = CLKComplicationTimelineEntry(date: currentDate, complicationTemplate: template!)
        
        handler(timeEntry)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
//        handler(nil)
        
        let eventDateAsString: String = "12 Jun 2016 09:00:00"
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        let eventDate = dateFormatter.dateFromString(eventDateAsString)!
        let currentDate = NSDate()
        
        let cal = NSCalendar.currentCalendar()
        let components = cal.components(.Day, fromDate: currentDate, toDate: eventDate, options: NSCalendarOptions.MatchFirst)
        
        var template: CLKComplicationTemplate?
        
        switch complication.family {
            case .ModularSmall:
                let modularSmallTemplate = CLKComplicationTemplateModularSmallRingText()
                modularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "\(components.day)")
                modularSmallTemplate.fillFraction = 1.0
                modularSmallTemplate.ringStyle = CLKComplicationRingStyle.Closed
                template = modularSmallTemplate
        
            case .ModularLarge:
                let modularLargeTemplate = CLKComplicationTemplateModularLargeTallBody()
                modularLargeTemplate.headerTextProvider = CLKSimpleTextProvider(text: "WWDC 2016", shortText: "WWDC16")
                modularLargeTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "\(components.day) days left", shortText: "Left: \(components.day)")
                template = modularLargeTemplate
            
            case .UtilitarianSmall:
                let utilitarianSmal = CLKComplicationTemplateUtilitarianSmallFlat()
                utilitarianSmal.textProvider = CLKSimpleTextProvider(text: "Days: \(components.day)", shortText: "\(components.day)")
                template = utilitarianSmal
        
            case .UtilitarianLarge:
                let utilitarianLarge = CLKComplicationTemplateUtilitarianLargeFlat()
                utilitarianLarge.textProvider = CLKSimpleTextProvider(text: "WWDC16: \(components.day)d \(components.hour):\(components.minute):\(components.second)", shortText: "Days left: \(components.day)")
                template = utilitarianLarge
            
            case .CircularSmall:
                let circularSmallTemplate = CLKComplicationTemplateCircularSmallRingText()
                circularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "\(components.day)")
                circularSmallTemplate.fillFraction = 0.25
                circularSmallTemplate.ringStyle = CLKComplicationRingStyle.Closed
                template = circularSmallTemplate
        }
        
        handler(template)
    }
    
}
