//
//  ViewController.swift
//  Crumful-Mil
//
//  Created by Marvin Allan Lu on 7/1/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var items = NSMutableArray()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        
        let project:JSON =  JSON(self.items[indexPath.row])

        cell!.textLabel?.text = project["name"].string
        
        return cell!
    }
    
    override func viewDidLoad() {
        
        RestApiManager.sharedInstance.getProjects { json in
            let results = json["projects"]
            
            for (index: String, project: JSON) in results {
                self.items.addObject(project.object)
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    return
                })
            }
        }
    }
    
}

