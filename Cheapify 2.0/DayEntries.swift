//
//  DayEntries.swift
//  Cheapify 2.0
//
//  Created by Carol on 7/5/15.
//  Copyright (c) 2015 Hip Hip Array[]. All rights reserved.
//

import UIKit

class DayEntries: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tblTasks : UITableView!
    var color: UIColor!
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        tblTasks.reloadData()
    }
    
    func setup(){
        entryMgr.tempArr.removeAll(keepCapacity: false)
        if(entryMgr.entries.count>0){
           for index in 0...entryMgr.entries.count-1 {
              if((entryMgr.entries[index].valueForKey("date") as? String)! == date){
                 entryMgr.tempArr.append(entryMgr.entries[index])
              }
           }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return entryMgr.tempArr.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Default Tasks")
        
        cell.textLabel?.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel?.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        cell.detailTextLabel?.numberOfLines = 0
        
        /*var myString: NSString = timestamp+"\r\n"+entryMgr.entries[indexPath.row].event+"\r\n"+entryMgr.entries[indexPath.row].category
        
        var myString2: NSString = "$"+entryMgr.entries[indexPath.row].price+"\r\n$"+entryMgr.entries[indexPath.row].tax+"\r\n$"+entryMgr.entries[indexPath.row].tip
        
        var myMutableString = NSMutableAttributedString()
        
        var myMutableString2 = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString, attributes: [NSFontAttributeName:UIFont(name: "System", size: 18.0)!])
        
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(location:1,length:countElements(timestamp)))
        
        UIFont yourFont = [UIFont fontWithName:@"System-Italic" size:[UIFont systemFontSize]]
        
        myMutableString.addAttribute(NSFontAttributeName, value: yourFont, range: NSRange(location:countElements(myString)-countElements(entryMgr.entries[indexPath.row].category), length:countElements(entryMgr.entries[indexPath.row].category)))
        
        myMutableString2 = NSMutableAttributedString(string: myString2, attributes: [NSFontAttributeName:UIFont(name: "System", size: 18.0)!])
        
        myMutableString2.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSRange(location:1, length:countElements(myString)))*/
        
        let entry = entryMgr.tempArr[indexPath.row]
        cell.textLabel?.text = (entry.valueForKey("date") as? String)!+"\r\n"+(entry.valueForKey("event") as? String)!+"\r\n"+(entry.valueForKey("category") as? String)!
        cell.detailTextLabel?.text = "Total: $"+(entry.valueForKey("price") as? String)!+"\r\n$"+(entry.valueForKey("tax") as? String)!+"\r\n$"+(entry.valueForKey("tip") as? String)!
        chooseColor((entry.valueForKey("category") as? String)!)
        cell.backgroundColor = color.colorWithAlphaComponent(0.3)
        
        return cell
    }
    
    /*func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle{
        /*if (editingStyle == UITableViewCellEditingStyle.Delete){
        entryMgr.entries.removeAtIndex(indexPath.row)
        tblTasks.reloadData()
        }*/
        return UITableViewCellEditingStyle.None
    }*/
    
    /*func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action , indexPath) -> Void in
            self.editing = false
            entryMgr.entries.removeAtIndex(indexPath.row)
            entryMgr.someInts.removeAtIndex(CVDate(date: NSDate()).day-1);
            self.tblTasks.reloadData()
        }
        
        var editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit") { (action , indexPath ) -> Void in
            self.editing = false
            self.path = indexPath
            self.performSegueWithIdentifier("edit", sender: self)
        }
        
        editAction.backgroundColor = UIColor.greenColor()

        return [editAction, deleteAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            var detailViewController = segue.destinationViewController as! DetailTableViewController
            
            detailViewController.index = path?.row
            detailViewController.entryArray = entryMgr.entries
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func saveToViewController (segue:UIStoryboardSegue) {
        
        let detailViewController = segue.sourceViewController as! DetailTableViewController
        
        let index = detailViewController.index
        
        let modelString1 = detailViewController.editedEvent
        let modelString2 = detailViewController.editedCategory
        let modelString3 = detailViewController.editedPrice
        let modelString4 = detailViewController.editedTax
        let modelString5 = detailViewController.editedTip
        
        entryMgr.entries[index!].event = modelString1!
        entryMgr.entries[index!].category = modelString2!
        entryMgr.entries[index!].price = modelString3!
        entryMgr.entries[index!].tax = modelString4!
        entryMgr.entries[index!].tip = modelString5!
        
        tblTasks.reloadData()
        
    }*/
    
    func chooseColor (cat: String) {
        if(cat == "Food")
        {
            color = UIColor(red: CGFloat(255)/255, green: CGFloat(224)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999);
        }
        else if(cat == "Personal")
        {
            color = UIColor(red: CGFloat(193)/255, green: CGFloat(224)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(cat == "Travel")
        {
            color =  UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(193)/255, alpha: 0.99999999999999);
        }
        else if(cat == "Transportation")
        {
            color = UIColor(red: CGFloat(224)/255, green: CGFloat(193)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(cat == "Business")
        {
            color = UIColor(red: CGFloat(193)/255, green: CGFloat(255)/255, blue: CGFloat(255)/255, alpha: 0.99999999999999);
        }
        else if(cat == "Entertainment")
        {
            color = UIColor(red: CGFloat(255)/255, green: CGFloat(127)/255, blue: CGFloat(127)/255, alpha: 0.99999999999999);
        }
        else if(cat == "Other")
        {
            color = UIColor(red: CGFloat(254)/255, green: CGFloat(254)/255, blue: CGFloat(199)/255, alpha: 0.99999999999999);
        }
    }
    
}