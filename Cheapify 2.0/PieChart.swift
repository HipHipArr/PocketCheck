//
//  PieChart.swift
//  Cheapify 2.0
//
//  Created by Maxime DAVID on 2015-04-03.
//  Edited by Carol and Mira on 7/7/15.
//  Copyright (c) 2015 Maxime DAVID. All rights reserved.
//

import UIKit

class PieChart: UIViewController, MDRotatingPieChartDelegate, MDRotatingPieChartDataSource {
    
    var slicesData:Array<Data> = Array<Data>()
    
    var pieChart:MDRotatingPieChart!

    //var changeBtn:UIButton!
    
    var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var button2:UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        button2.layer.cornerRadius = 23.0
        button2.layer.borderWidth = 1.5
        
        configureButton()
        
        label.textColor = UIColor.redColor()
        total.textColor = UIColor.redColor()
        
        if(entryMgr.budget == 0.0){
            entryMgr.budget = 0.1
        }
        
        
        label.text = "Budget: $"+entryMgr.budget.description
        total.text = "Total Spent: $"+entryMgr.total.description
        
        
        pieChart = MDRotatingPieChart(frame: CGRectMake(0, 8, view.frame.width, view.frame.width))
    
        slicesData = [
            Data(myValue: CGFloat(entryMgr.tFood), myColor: UIColor(red: CGFloat(255)/255, green: CGFloat(224)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999), myLabel: "Food"),
            Data(myValue: CGFloat(entryMgr.tPers), myColor: UIColor(red: CGFloat(193)/255, green: CGFloat(224)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999), myLabel: "Personal"),
            Data(myValue: CGFloat(entryMgr.tTrav), myColor: UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999), myLabel: "Travel"),
            Data(myValue: CGFloat(entryMgr.tTran), myColor: UIColor(red: CGFloat(224)/255, green: CGFloat(193)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999), myLabel: "Transportation"),
            Data(myValue: CGFloat(entryMgr.tBusi), myColor: UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999), myLabel: "Business"),
            Data(myValue: CGFloat(entryMgr.tEnte), myColor: UIColor(red: CGFloat(255)/255, green: CGFloat(127)/255, blue: CGFloat(127)/255, alpha: 0.99999999999999), myLabel: "Entertainment"),
            Data(myValue: CGFloat(entryMgr.tOthe), myColor: UIColor(red: CGFloat(254)/255, green: CGFloat(254)/255, blue: CGFloat(199)/255, alpha: 0.99999999999999), myLabel: "Other"),
            Data(myValue: CGFloat((entryMgr.budget-entryMgr.total)), myColor: UIColor(red: CGFloat(215)/255, green: CGFloat(215)/255, blue: CGFloat(215)/255, alpha: 0.99999999999999), myLabel: "Unspent")
        ]
        
        pieChart.delegate = self
        pieChart.datasource = self
        
        view.addSubview(pieChart)
        
        /*let budgetBtn = UIButton(frame: CGRectMake((view.frame.width-100)/2, (view.frame.width-190)/2, 100, 30))
        budgetBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        budgetBtn.setTitle("Set Budget", forState: UIControlState.Normal)
        budgetBtn.addTarget(self, action: "appear", forControlEvents: UIControlEvents.TouchUpInside)
        budgetBtn.backgroundColor = UIColor.greenColor()
        view.addSubview(budgetBtn)*/
        
        let budgetBtn = UIButton(frame: CGRectMake((view.frame.width-200)/2, view.frame.width+123, 200, 50))
        budgetBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        budgetBtn.setTitle("Set Budget", forState: UIControlState.Normal)
        budgetBtn.addTarget(self, action: "appear", forControlEvents: UIControlEvents.TouchUpInside)
        budgetBtn.backgroundColor = UIColor(red: CGFloat(116)/255, green: CGFloat(232)/255, blue: CGFloat(182)/255, alpha: 0.99999999999999)
        view.addSubview(budgetBtn)
        
    }
    
    func change(){
        slicesData = [
            Data(myValue: CGFloat(entryMgr.tFood), myColor: UIColor(red: CGFloat(255)/255, green: CGFloat(224)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999), myLabel: "Food"),
            Data(myValue: CGFloat(entryMgr.tPers), myColor: UIColor(red: CGFloat(193)/255, green: CGFloat(224)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999), myLabel: "Personal"),
            Data(myValue: CGFloat(entryMgr.tTrav), myColor: UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999), myLabel: "Travel"),
            Data(myValue: CGFloat(entryMgr.tTran), myColor: UIColor(red: CGFloat(224)/255, green: CGFloat(193)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999), myLabel: "Transportation"),
            Data(myValue: CGFloat(entryMgr.tBusi), myColor: UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999), myLabel: "Business"),
            Data(myValue: CGFloat(entryMgr.tEnte), myColor: UIColor(red: CGFloat(255)/255, green: CGFloat(127)/255, blue: CGFloat(127)/255, alpha: 0.99999999999999), myLabel: "Entertainment"),
            Data(myValue: CGFloat(entryMgr.tOthe), myColor: UIColor(red: CGFloat(254)/255, green: CGFloat(254)/255, blue: CGFloat(199)/255, alpha: 0.99999999999999), myLabel: "Other"),
            Data(myValue: CGFloat((entryMgr.budget-entryMgr.total)), myColor: UIColor(red: CGFloat(215)/255, green: CGFloat(215)/255, blue: CGFloat(215)/255, alpha: 0.99999999999999), myLabel: "Unspent")
        ]

    }
    
    //Delegate
    //some sample messages when actions are triggered (open/close slices)
    func didOpenSliceAtIndex(index: Int) {
        //refreshBtn.hidden = false
    }
    
    func didCloseSliceAtIndex(index: Int) {
        //println("Close slice at \(index)")
    }
    
    func willOpenSliceAtIndex(index: Int) {
        //println("Will open slice at \(index)")
    }
    
    func willCloseSliceAtIndex(index: Int) {
        //println("Will close slice at \(index)")
    }
    
    //Datasource
    func colorForSliceAtIndex(index:Int) -> UIColor {
        return slicesData[index].color
    }
    
    func valueForSliceAtIndex(index:Int) -> CGFloat {
        return slicesData[index].value
    }
    
    func labelForSliceAtIndex(index:Int) -> String {
        return "\(slicesData[index].label)"
    }
    
    func labelNumForSliceAtIndex(index: Int) ->String   {
        return "$\(slicesData[index].value)"
    }
    
    func numberOfSlices() -> Int {
        return slicesData.count
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    //Changes the state of the "more information" button
    func changeButton(index: Int, sender: UIButton!) {
        
    }
    
    func refresh() {
        pieChart.build()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func appear() {
        var alert = UIAlertController(title: "Set Budget", message: "This can be your weekly, monthy, or yearly budget.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Ex: 100.0"
            textField.secureTextEntry = false
            self.textField = textField
        })
        alert.addAction(UIAlertAction(title: "Set", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            entryMgr.budget = (self.textField.text as NSString).doubleValue
            self.label.text = "Budget: $"+entryMgr.budget.description
            self.configureButton()
            self.change()
            self.refresh()
            entryMgr.saveName()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
//  Method created by Amanda on 7/1/15
//  Copyright (c) 2015 Hip Hip Array. All rights reserved.
    
    func configureButton(){
        var percent = entryMgr.total/entryMgr.budget*100
        if (percent == 0){
            button2.backgroundColor = UIColor(red: CGFloat(76)/255, green: CGFloat(195)/255, blue: CGFloat(57)/255, alpha: 0.99999999999999);
        }
        if (percent < 6.667){
            button2.backgroundColor = UIColor(red: CGFloat(76)/255, green: CGFloat(195)/255, blue: CGFloat(57)/255, alpha: 0.99999999999999);
        }
        else if (percent < 13.333){
            button2.backgroundColor = UIColor(red: CGFloat(39)/255, green: CGFloat(255)/255, blue: CGFloat(10)/255, alpha: 0.99999999999999);
        }
        else if (percent < 20){
            button2.backgroundColor = UIColor(red: CGFloat(169)/255, green: CGFloat(246)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 26.668){
            button2.backgroundColor = UIColor(red: CGFloat(200)/255, green: CGFloat(246)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 33.334){
            button2.backgroundColor = UIColor(red: CGFloat(223)/255, green: CGFloat(246)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 40){
            button2.backgroundColor = UIColor(red: CGFloat(238)/255, green: CGFloat(246)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 46.667){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(223)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 53.335){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(200)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 60){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(177)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 66.66){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(154)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 73.334){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(131)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 80){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(123)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 86.6667){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(100)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 93.337){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(84)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent < 100){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(15)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent > 100){
            button2.backgroundColor = UIColor(red: CGFloat(0)/255, green: CGFloat(0)/255, blue: CGFloat(0)/255, alpha: 0.99999999999999);
        }
        button2.tintColor = UIColor.whiteColor()
    }

}

class Data {
    var value:CGFloat
    var color:UIColor = UIColor.grayColor()
    var label:String = ""
    
    init(myValue:CGFloat, myColor:UIColor, myLabel:String) {
        value = myValue
        color = myColor
        label = myLabel
    }
}

