//
//  Person+CoreDataProperties.swift
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

extension Person {

    @NSManaged var born: String?
    @NSManaged var email: String?
    @NSManaged var linkLinkedin: String?
    @NSManaged var linkGithub: String?
    @NSManaged var linkFacebook: String?
    @NSManaged var locationName: String?
    @NSManaged var jobs: String?
    @NSManaged var aLittleMore: String?
    @NSManaged var cellPhone: String?

}
