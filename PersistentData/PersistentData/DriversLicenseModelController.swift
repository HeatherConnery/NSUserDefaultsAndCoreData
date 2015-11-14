//
//  DriversLicenseModelController.swift
//  PersistentData
//
//  Created by Heather Connery on 2015-11-13.
//  Copyright © 2015 HConnery. All rights reserved.
//

import UIKit
import CoreData

class DriversLicenseModelController: NSObject {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let data = [
        "Street Address 1": "1101-322 EGLINTON AVE EAST",
        "Document Discriminator": "DE4171679",
        "Customer Id Number": "L0559-38317-60408?",
        "Class": "G2",
        "Endorsements": "NONE",
        "Restrictions": "X",
        "Jurisdiction Code": "ON",
        "Postal Code": "M4P 1L6",
        "Expiration Date": "20180320",
        "Height": "185 cm",
        "Country Identification": "CAN",
        "Vehicle Code": "NONE",
        "Date Of Birth": "19760408",
        "Customer Family Name": "LARCOMBE",
        "Eye Color": "NONE",
        "Sex": "1",
        "Customer Given Name": "JAMES,ANDREW",
        "City": "TORONTO",
        "Issue Date": "20150429"
    ]
    
    //let two = 2
    //for NSUserDefaults:
    var defaultsData: [String:String]?
    
    
    
    
    func fetchDataFromDefaults() {
        if let object = defaults.objectForKey("data") as? [String:String]  {
            defaultsData = object
            // print("There was data: \(defaultsData)")
            
        } else {
            print("There was no info in the user defaults")
            return
        }
        
    }
    
    
    func fetchData(licenses:([DriversLicense]) -> ()) throws {
        // this fn has a single input param which is a fn, refered to locally as licenses
        // func fetchData(inputParam: (arrayOfClassDriversLicenseObjects) -> (nil) ) throws {
        // regular fn syntax: func somefn(input: inputType) -> rtnType {
        
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("DriversLicense", inManagedObjectContext: appDelegate.managedObjectContext)
        fetchRequest.entity = entity
        
        var arrayOfLicenses:[AnyObject] = []
        do {
            arrayOfLicenses = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let error {
            print("There was an error reading in data from drive: \(error)")
            licenses([])
            throw error
        }
        
        if let licenseArray = arrayOfLicenses as? [DriversLicense] {
            licenses(licenseArray)
        } else {
            //not the right type can't cast them, rtn empty array
            licenses([])
        }

    }
    
    
    
    func saveDataToDefaults() {
        defaults.setValue(data, forKey: "data")
        //defaults.setInteger(2, forKey: "two")
        defaults.synchronize()
    }
    
    func createDriversLicenseObjectWithId(licenseId:String,country:String,givenName:String,lastName:String,streetAddress:String,dateOfBirth:String) throws {
        
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        //create object inside managed object context - using throws => user must wrap in do/catch loop
        //save as core data object
        
        
        //below returns NSMutableDictionary, so we can use a let below and still add/remove keys from value set
        let license = NSEntityDescription.insertNewObjectForEntityForName("DriversLicense", inManagedObjectContext: appDelegate.managedObjectContext)
        
        // set keys in actual data for keys in model entity
        license.setValue(country , forKey: "country" )
        license.setValue(givenName , forKey: "givenName" )
        license.setValue(lastName , forKey: "lastName" )
        license.setValue(licenseId , forKey: "licenseId" )
        license.setValue(streetAddress , forKey: "streetAddress" )
        license.setValue(dateOfBirth , forKey: "dateOfBirth" )
        
        // need to wrap managedObjectContext in do catch loop b/c something could go wrong - see in autocompletion throws
        do {
            try appDelegate.managedObjectContext.save()
        } catch let error {
            print("Error saving data: \(error)")
            throw error //throws error back to whomever called it - they deal with it there, instead of here (eg at the view controller sends alert to usr)
        }
    }
    

    


}
