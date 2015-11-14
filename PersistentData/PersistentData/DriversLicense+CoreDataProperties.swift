//
//  DriversLicense+CoreDataProperties.swift
//  PersistentData
//
//  Created by Heather Connery on 2015-11-13.
//  Copyright © 2015 HConnery. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

//changing run time properties on the fly - swizzling /categories/extensions
import Foundation
import CoreData

extension DriversLicense {

    @NSManaged var country: String?
    @NSManaged var givenName: String?
    @NSManaged var streetAddress: String?
    @NSManaged var licenseId: String?
    @NSManaged var lastName: String?
    @NSManaged var dateOfBirth: String?

}
