//
//  DetailTableViewController.swift
//  Cheapify 2.0
//
//  Created by Carol on 7/1/15.
//  Copyright (c) 2015 Hip Hip Array[]. All rights reserved.
//

import UIKit
import CoreData

class DetailTableViewController: UITableViewController {

    @IBOutlet var eventTxt: UITextField!
    @IBOutlet var categoryTxt: UITextField!
    @IBOutlet var priceTxt: UITextField!
    @IBOutlet var taxTxt: UITextField!
    @IBOutlet var tipTxt: UITextField!
    
    var index:Int!
    
    var entryArray:[NSManagedObject]! = entryMgr.entries
    
    var editedEvent: String!
    var editedCategory: String!
    var editedPrice: String!
    var editedTax: String!
    var editedTip: String!
    var editedDate: String!
    
    @IBOutlet var pickerView: UIPickerView!
    
    var dataSource = ["Food", "Personal", "Travel", "Transportation", "Business", "Entertainment", "Other"]
    
    var val: String = ""
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            eventTxt.becomeFirstResponder()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let entry = entryArray[index]
        var row: Int! = find(dataSource, (entry.valueForKey("category") as? String)!)
        
        eventTxt.text = (entry.valueForKey("event") as? String)!
        pickerView.selectRow(row, inComponent: 0, animated: true)
        priceTxt.text = (entry.valueForKey("price") as? String)!
        taxTxt.text = (entry.valueForKey("tax") as? String)!
        tipTxt.text = (entry.valueForKey("tip") as? String)!
        if(row == 0)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(255)/255, green: CGFloat(224)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999);
            //self.tableView.backgroundColor = [UIColor, clearColor];
        }
        else if(row == 1)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(193)/255, green: CGFloat(224)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(row == 2)
        {
            self.view.backgroundColor =  UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999);
        }
        else if(row == 3)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(224)/255, green: CGFloat(193)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(row == 4)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(row == 5)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(255)/255, green: CGFloat(127)/255, blue: CGFloat(127)/255, alpha: 0.99999999999999);
        }
        else if(row == 6)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(254)/255, green: CGFloat(254)/255, blue: CGFloat(199)/255, alpha: 0.99999999999999);
        }
        val = dataSource[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            editedEvent = eventTxt.text
            editedCategory = val
            editedPrice = priceTxt.text
            editedTax = taxTxt.text
            editedTip = tipTxt.text
            
            var viewController = segue.destinationViewController as! ViewController
            var startIndex = advance(editedPrice.startIndex, 0)
            var endIndex = advance(editedPrice.endIndex, 0)
            var range = startIndex..<endIndex
            var myNewString = editedPrice.substringWithRange(range)
            entryMgr.total = entryMgr.total + (myNewString as NSString).doubleValue
            self.subTotal(false)
            viewController.label.text = "Total: $"+entryMgr.total.description
            
            var todaysDate:NSDate = NSDate()
            var dateFormatter:NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "M-d-yyyy"// HH:mm"
            var DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
            editedDate = DateInFormat
            entryMgr.saveName()
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return dataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(255)/255, green: CGFloat(224)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999);
        }
        else if(row == 1)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(193)/255, green: CGFloat(224)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(row == 2)
        {
            self.view.backgroundColor =  UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999);
        }
        else if(row == 3)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(224)/255, green: CGFloat(193)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(row == 4)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(row == 5)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(255)/255, green: CGFloat(127)/255, blue: CGFloat(127)/255, alpha: 0.99999999999999);
        }
        else if(row == 6)
        {
            self.view.backgroundColor = UIColor(red: CGFloat(254)/255, green: CGFloat(254)/255, blue: CGFloat(199)/255, alpha: 0.99999999999999);
        }
        val = dataSource[row]
    }
    
    func subTotal(subtract: Bool){
        var startIndex = advance(editedPrice.startIndex, 0)
        var endIndex = advance(editedPrice.endIndex, 0)
        var range = startIndex..<endIndex
        var myNewString = editedPrice.substringWithRange(range)
        var subtractVal = (myNewString as NSString).doubleValue
        if(subtract){
            subtractVal = 0-subtractVal;
        }
        if(editedCategory == "Food"){
            entryMgr.tFood = entryMgr.tFood + subtractVal
        }
        if(editedCategory == "Transportation"){
            entryMgr.tTran = entryMgr.tTran + subtractVal
        }
        
        if(editedCategory == "Other"){
            entryMgr.tOthe = entryMgr.tOthe + subtractVal
        }
        
        if(editedCategory == "Business"){
            entryMgr.tBusi = entryMgr.tBusi + subtractVal
        }
        
        if(editedCategory == "Personal"){
            entryMgr.tPers = entryMgr.tPers + subtractVal
        }
        
        if(editedCategory == "Entertainment"){
            entryMgr.tEnte = entryMgr.tEnte + subtractVal
        }
        if(editedCategory == "Travel"){
            entryMgr.tTrav = entryMgr.tTrav + subtractVal
        }
    }
    
}
