//
//  ViewController.swift
//  PersistentData
//
//  Created by Heather Connery on 2015-11-13.
//  Copyright © 2015 HConnery. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data:[DriversLicense]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchLicenses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // two versions of below: returns either optional cell vs. cell, here it's cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let license = data?[indexPath.row]
        cell.textLabel?.text = license?.lastName
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellAmount = 0
        if let actualData = data {
            cellAmount = actualData.count
        }
        return cellAmount
    }

    func fetchLicenses() {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        do {
            //whatever we get back from fetchData we want to call licenses and we pass the responsibility to
            try appDelegate.licenseController.fetchData { (licenses) -> () in
                //this code, which goes to dispatch.
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //When returned, set result to property called data and reload the tableView
                    self.data = licenses
                    self.tableView.reloadData()
                })
            }

        } catch let error  {
            print("Error caught: \(error)")
        }
    }
   
    @IBAction func addNewLicenseSelected(sender: AnyObject) {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        do {
            try appDelegate.licenseController.createDriversLicenseObjectWithId("1234", country: "CAN", givenName: "Poppa", lastName: "Murphy", streetAddress: "Anywhere but here", dateOfBirth: "Yesterday")
        } catch let error {
            print("Error creating new entity: \(error)")
        }
        fetchLicenses()
    }
}

