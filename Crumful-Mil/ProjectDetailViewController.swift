//
//  ProjectDetailViewController.swift
//  Crumful-Mil
//
//  Created by Marvin Allan Lu on 7/3/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import UIKit
import Charts

class ProjectDetailViewController: UIViewController, ChartViewDelegate {
    var projectName: String = ""
    var projectId: Int = Int.min
        
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var weeksLabel: UILabel!
    @IBOutlet var estimatedLabel: UILabel!
    @IBOutlet var pie: PieChartView!
    
    @IBOutlet var test: UIView!
    
    override func viewDidLoad() {
        
        RestApiManager.sharedInstance.getProject(self.projectId) {
            json in
            self.projectName = json["name"].string!
            println(json)
        }
        
        self.tabBarController?.title = self.projectName
        
        
        var yVals = [BarChartDataEntry]()
        var xVals = [String]()
        
        for(var i = 0; i < 3; i++) {
            let blah = BarChartDataEntry(value: Float(arc4random_uniform(30)), xIndex: i)
            yVals.append(blah)
            xVals.append("Test")
        }
        
        let dataSet = PieChartDataSet(yVals: yVals, label: "Testing")
        let data = PieChartData(xVals: xVals, dataSet: dataSet)
        
        pie = PieChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        pie.data = data
        pie.animate(xAxisDuration: 0.0)
        
        test.addSubview(pie)
        
        //TJ - Pwede din i2. j3j3j3j
//        self.tabBarController?.navigationItem.title = self.projectName
    }

}
