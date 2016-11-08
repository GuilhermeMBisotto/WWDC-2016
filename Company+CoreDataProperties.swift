//
//  Company+CoreDataProperties.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/25/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Company {

    @NSManaged var companyID: NSNumber?
    @NSManaged var companyName: String?
    @NSManaged var desc: String?
    @NSManaged var function: String?
    @NSManaged var timeInCompany: String?

}
