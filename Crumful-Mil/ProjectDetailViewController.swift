//
//  ProjectDetailViewController.swift
//  Crumful-Mil
//
//  Created by Marvin Allan Lu on 7/3/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit
import SwiftyJSON
import Charts

class ProjectDetailViewController: UIViewController, ChartViewDelegate {
    var projectName: String = ""
    var projectId: Int = Int.min
    var thisWeek = [
        "accepted_stories" : 0,
        "started_stories" : 0,
        "finished_stories" : 0,
        "outstanding_bugs" : 0,
        "closed_bugs" : 0,
        "delivered_stories" : 0,
        "rejected_stories" : 0
    ]
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var weeksLabel: UILabel!
    @IBOutlet var estimatedLabel: UILabel!
    @IBOutlet var pie: PieChartView!
    
    @IBOutlet var test: UIView!
    
    func prepareDataForPieChart() {
        
        println("*** logbet ***")
        
        var yVals = [BarChartDataEntry]()
        var xVals = [String]()
        
        var index = 0;
        
        for (key, value) in self.thisWeek {
            
            if value == 0 { continue }
            
            let dataEntry = BarChartDataEntry(value: Float(value), xIndex: index)
            yVals.append(dataEntry)
            
            let humanizedKey = " ".join(key.componentsSeparatedByString("_")).capitalizedString
            xVals.append(humanizedKey)
            
            index++
        }
        
        println(yVals)
   
        
//        for(var i = 0; i < 3; i++) {
//            let blah = BarChartDataEntry(value: Float(arc4random_uniform(30)), xIndex: i)
//            yVals.append(blah)
//        }
        
        let dataSet = PieChartDataSet(yVals: yVals, label: "This Week")
        let data = PieChartData(xVals: xVals, dataSet: dataSet)
        
        
        // layku 
//        [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//        [colors addObjectsFromArray:ChartColorTemplates.joyful];
//        [colors addObjectsFromArray:ChartColorTemplates.colorful];
//        [colors addObjectsFromArray:ChartColorTemplates.liberty];
//        [colors addObjectsFromArray:ChartColorTemplates.pastel];
        
        var colors = [UIColor]()
        colors.extend(ChartColorTemplates.vordiplom())
        
        dataSet.colors = colors
        
        pie = PieChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        pie.data = data
        pie.animate(xAxisDuration: 0.0)
        
        test.addSubview(pie)
        
    }
    
    override func viewDidLoad() {
        
        RestApiManager.sharedInstance.getProject(self.projectId) {
            json in
            self.projectName = json["name"].string!
            let thisWeekArray = json["this_week"]
            
            println("**** thisWeekArray ***")
            println(thisWeekArray)
            
            // Reduce :+1:
            for (index, person) in thisWeekArray as JSON {
                for key in self.thisWeek.keys {
                    self.thisWeek[key] = person[key].int
                }
            }
            println("*** self.thisWeek ***")
            println(self.thisWeek)
            
            self.tabBarController?.title = self.projectName
            self.prepareDataForPieChart()

        }
      
        
    }

}
