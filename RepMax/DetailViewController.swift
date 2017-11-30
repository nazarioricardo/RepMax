//
//  DetailViewController.swift
//  RepMax
//
//  Created by Ricardo Nazario on 11/29/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit
import Charts

class DetailViewController: UIViewController, ChartDelegate, ChartViewDelegate {
    
    var exercise: Exercise!
    var chartDataEntries: [ChartDataEntry] = []
    let data = LineChartData()
    
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dataManager.chartDelegate = self
        lineChart.delegate = self
        
        dateLabel.text = ""
        weightLabel.text = ""

        dataManager.setChartDataPoints(for: exercise)
        self.title = exercise.name
        
        lineChart.chartDescription?.text = ""
        lineChart.xAxis.labelPosition = .bottom
        lineChart.leftAxis.drawAxisLineEnabled = false
        lineChart.leftAxis.drawLabelsEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawAxisLineEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDataPoints(dataPoints: [[Int]]) {
        print("Data Points \(dataPoints)")

        let x = dataPoints[0]
        let y = dataPoints[1]
        
        for i in 0..<x.count {
            let dataEntry = ChartDataEntry(x: Double(x[i]), y: Double(y[i]))
            chartDataEntries.append(dataEntry)
        }
        
        let line = LineChartDataSet(values: chartDataEntries, label: "Number")
        line.circleRadius = 3
        line.valueColors = [NSUIColor.clear]
        data.addDataSet(line)
        lineChart.data = data
    }
}
