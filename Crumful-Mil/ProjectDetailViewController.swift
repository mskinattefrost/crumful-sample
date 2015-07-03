//
//  ProjectDetailViewController.swift
//  Crumful-Mil
//
//  Created by Marvin Allan Lu on 7/3/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController {

    var projectName: String = ""
    var projectId: Int = Int.min
    
    @IBOutlet var projectNameLabel: UILabel!
    
    override func viewDidLoad() {
        RestApiManager.sharedInstance.getProject(self.projectId) {
            json in
            self.projectName = json["name"].string!
            let thisWeek = json["this_week"]
            
            for stat in thisWeek {
                println(stat)
            }
            
          
        }
        self.projectNameLabel.text = self.projectName
        
    }

}
