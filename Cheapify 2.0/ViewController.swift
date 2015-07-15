//
//  ViewController.swift
//  Cheapify 2.0
//
//  Created by Carol on 7/1/15.
//  Copyright (c) 2015 Hip Hip Array[]. All rights reserved.
//

import UIKit
import CoreData

var first: Bool = true
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideBarDelegate {

    @IBOutlet var tblTasks : UITableView!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var button2: UIButton!
    var path: NSIndexPath!
    var color: UIColor!
    var sideBar: SideBar = SideBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button2.layer.cornerRadius = 23.0
        button2.layer.borderWidth = 1.5
        
        configureButton()
        tblTasks.reloadData()
        sideBar = SideBar(sourceView: self.view, menuItems: ["Food", "Personal", "Travel", "Transportation", "Business", "Entertainment", "Other"])
        sideBar.delegate = self
        
        for index in 1...31 {
            entryMgr.jan.append("0")
            entryMgr.feb.append("0")
            entryMgr.mar.append("0")
            entryMgr.apr.append("0")
            entryMgr.may.append("0")
            entryMgr.jun.append("0")
            entryMgr.jul.append("0")
            entryMgr.aug.append("0")
            entryMgr.sep.append("0")
            entryMgr.oct.append("0")
            entryMgr.nov.append("0")
            entryMgr.dec.append("0")
        }
        
        label.text = "Total: $"+entryMgr.total.description
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(first==true){
            first = false
            //1
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
            let managedContext = appDelegate.managedObjectContext!
        
            //2
            let fetchRequest = NSFetchRequest(entityName:"Entry")
        
            //3
            var error: NSError?
            let fetchedResults =
            managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
            if let results = fetchedResults {
                entryMgr.entries = results
            } else {
                println("Could not fetch \(error), \(error!.userInfo)")
            }
        
            let fetchRequest2 = NSFetchRequest(entityName: "Info")
        
            let fetchedResults2 = managedContext.executeFetchRequest(fetchRequest2, error: &error) as? [NSManagedObject]
        
            if let results = fetchedResults2 {
                entryMgr.moneyinfo = results
            } else {
                println("Could not fetch \(error), \(error!.userInfo)")
            }
        
            var index = entryMgr.moneyinfo.count-1
            if entryMgr.moneyinfo.count > 0 {
                entryMgr.total = (entryMgr.moneyinfo[index].valueForKey("total") as? Double)!
                entryMgr.tFood = (entryMgr.moneyinfo[index].valueForKey("tFood") as? Double)!
                entryMgr.tTran = (entryMgr.moneyinfo[index].valueForKey("tTran") as? Double)!
                entryMgr.tTrav = (entryMgr.moneyinfo[index].valueForKey("tTrav") as? Double)!
                entryMgr.tEnte = (entryMgr.moneyinfo[index].valueForKey("tEnte") as? Double)!
                entryMgr.tOthe = (entryMgr.moneyinfo[index].valueForKey("tOthe") as? Double)!
                entryMgr.tPers = (entryMgr.moneyinfo[index].valueForKey("tPers") as? Double)!
                entryMgr.tBusi = (entryMgr.moneyinfo[index].valueForKey("tBusi") as? Double)!
                entryMgr.budget = (entryMgr.moneyinfo[index].valueForKey("budget") as? Double)!
            }
        }
        
        button2.layer.cornerRadius = 23.0
        button2.layer.borderWidth = 1.5
        
        configureButton()
        tblTasks.reloadData()
        sideBar = SideBar(sourceView: self.view, menuItems: ["Food", "Personal", "Travel", "Transportation", "Business", "Entertainment", "Other"])
        sideBar.delegate = self
        
        for index in 1...31 {
            entryMgr.jan.append("0")
            entryMgr.feb.append("0")
            entryMgr.mar.append("0")
            entryMgr.apr.append("0")
            entryMgr.may.append("0")
            entryMgr.jun.append("0")
            entryMgr.jul.append("0")
            entryMgr.aug.append("0")
            entryMgr.sep.append("0")
            entryMgr.oct.append("0")
            entryMgr.nov.append("0")
            entryMgr.dec.append("0")
        }
        
        label.text = "Total: $"+entryMgr.total.description
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return entryMgr.entries.count
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
        
        var todaysDate:NSDate = NSDate()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M-d-yyyy"// HH:mm"
        var DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        
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
        
        let entry = entryMgr.entries[indexPath.row]
        cell.textLabel?.text = (entry.valueForKey("date") as? String)!+"\r\n"+(entry.valueForKey("event") as? String)!+"\r\n"+(entry.valueForKey("category") as? String)!
        cell.detailTextLabel?.text = "Total: $"+(entry.valueForKey("price") as? String)!+"\r\n$"+(entry.valueForKey("tax") as? String)!+"\r\n$"+(entry.valueForKey("tip") as? String)!
        chooseColor((entry.valueForKey("category") as? String)!)
        cell.backgroundColor = color.colorWithAlphaComponent(0.3)
        
        addDate(entryMgr.entries[indexPath.row])
        
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        /*if (editingStyle == UITableViewCellEditingStyle.Delete){
            entryMgr.entries.removeAtIndex(indexPath.row)
            tblTasks.reloadData()
        }*/
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action , indexPath) -> Void in
            self.editing = false
            
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext!
            
            let entry = entryMgr.entries[indexPath.row]
            var startIndex = advance((entry.valueForKey("price") as? String)!.startIndex, 0)
            var endIndex = advance((entry.valueForKey("price") as? String)!.endIndex, 0)
            var range = startIndex..<endIndex
            var myNewString = (entry.valueForKey("price") as? String)!.substringWithRange(range)
            entryMgr.total = entryMgr.total - (myNewString as NSString).doubleValue
            self.label.text = "Total: $"+entryMgr.total.description
            self.subTotal(true, indexPath: indexPath)
            
            self.removeDate(entryMgr.entries[indexPath.row])
            
            managedContext.deleteObject(entryMgr.entries[indexPath.row])
            managedContext.save(nil)
            
            entryMgr.entries.removeAtIndex(indexPath.row)
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
            
            entryMgr.saveName()
            self.configureButton()
            self.tblTasks.reloadData()
        }
        
        var editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit") { (action , indexPath ) -> Void in
            self.editing = false
            self.path = indexPath
            
            let entry = entryMgr.entries[indexPath.row]
            var startIndex = advance((entry.valueForKey("price") as? String)!.startIndex, 0)
            var endIndex = advance((entry.valueForKey("price") as? String)!.endIndex, 0)
            var range = startIndex..<endIndex
            var myNewString = (entry.valueForKey("price") as? String)!.substringWithRange(range)
            entryMgr.total = entryMgr.total - (myNewString as NSString).doubleValue
            self.subTotal(true, indexPath: indexPath)
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
        if segue.identifier == "add" {
            var addentry = segue.destinationViewController as! AddEntry
            
            addentry.viewController = self
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
        let modelString6 = detailViewController.editedDate
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        entryMgr.entries[index!].setValue(modelString1, forKey: "event")
        entryMgr.entries[index!].setValue(modelString2, forKey: "category")
        entryMgr.entries[index!].setValue(modelString3, forKey: "price")
        entryMgr.entries[index!].setValue(modelString4, forKey: "tax")
        entryMgr.entries[index!].setValue(modelString5, forKey: "tip")
        entryMgr.entries[index!].setValue(modelString6, forKey: "date")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        configureButton()
        tblTasks.reloadData()
        
    }
    
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
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        entryMgr.categoryname = sideBar.sideBarTableViewController.tableData[index]
        self.performSegueWithIdentifier("category", sender: self);
    }
    
    func subTotal(subtract: Bool, indexPath: NSIndexPath){
        let entry = entryMgr.entries[indexPath.row]
        let cat = entry.valueForKey("category") as? String
        var startIndex = advance((entry.valueForKey("price") as? String)!.startIndex, 0)
        var endIndex = advance((entry.valueForKey("price") as? String)!.endIndex, 0)
        var range = startIndex..<endIndex
        var myNewString = (entry.valueForKey("price") as? String)!.substringWithRange(range)
        var subtractVal = (myNewString as NSString).doubleValue
        if(subtract){
            subtractVal = 0-subtractVal;
        }
        if(cat == "Food"){
            entryMgr.tFood = entryMgr.tFood + subtractVal
        }
        if(cat == "Transportation"){
            entryMgr.tTran = entryMgr.tTran + subtractVal
        }

        if(cat == "Other"){
            entryMgr.tOthe = entryMgr.tOthe + subtractVal
        }

        if(cat == "Business"){
            entryMgr.tBusi = entryMgr.tBusi + subtractVal
        }

        if(cat == "Personal"){
            entryMgr.tPers = entryMgr.tPers + subtractVal
        }

        if(cat == "Entertainment"){
            entryMgr.tEnte = entryMgr.tEnte + subtractVal
        }
        if(cat == "Travel"){
            entryMgr.tTrav = entryMgr.tTrav + subtractVal
        }
        entryMgr.saveName()
    }
    
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
        else if (percent <= 100){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(15)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent > 100){
            button2.backgroundColor = UIColor(red: CGFloat(0)/255, green: CGFloat(0)/255, blue: CGFloat(0)/255, alpha: 0.99999999999999);
        }
        button2.tintColor = UIColor.whiteColor()
    }
    
    func addDate(entry: NSManagedObject){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M-d-yyyy"
        let date = dateFormatter.dateFromString((entry.valueForKey("date") as? String)!)
        if(CVDate(date: date!).month==1){
           if entryMgr.jan[CVDate(date: date!).day-1] != "1" {
               entryMgr.jan.insert("1", atIndex: CVDate(date: date!).day-1)
           }
        }
        if(CVDate(date: date!).month==2){
            if entryMgr.feb[CVDate(date: date!).day-1] != "1" {
                entryMgr.feb.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==3){
            if entryMgr.mar[CVDate(date: date!).day-1] != "1" {
                entryMgr.mar.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==4){
            if entryMgr.apr[CVDate(date: date!).day-1] != "1" {
                entryMgr.apr.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==5){
            if entryMgr.may[CVDate(date: date!).day-1] != "1" {
                entryMgr.may.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==6){
            if entryMgr.jun[CVDate(date: date!).day-1] != "1" {
                entryMgr.jun.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==7){
            if entryMgr.jul[CVDate(date: date!).day-1] != "1" {
                entryMgr.jul.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==8){
            if entryMgr.aug[CVDate(date: date!).day-1] != "1" {
                entryMgr.aug.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==9){
            if entryMgr.sep[CVDate(date: date!).day-1] != "1" {
                entryMgr.sep.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==10){
            if entryMgr.oct[CVDate(date: date!).day-1] != "1" {
                entryMgr.oct.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==11){
            if entryMgr.nov[CVDate(date: date!).day-1] != "1" {
                entryMgr.nov.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
        if(CVDate(date: date!).month==12){
            if entryMgr.dec[CVDate(date: date!).day-1] != "1" {
                entryMgr.dec.insert("1", atIndex: CVDate(date: date!).day-1)
            }
        }
    }
    
    func removeDate(entry: NSManagedObject){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M-d-yyyy"
        let date = dateFormatter.dateFromString((entry.valueForKey("date") as? String)!)
        if(CVDate(date: date!).month==1){
            entryMgr.jan.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==2){
            entryMgr.feb.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==3){
            entryMgr.mar.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==4){
            entryMgr.apr.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==5){
            entryMgr.may.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==6){
            entryMgr.jun.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==7){
            entryMgr.jul.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==8){
            entryMgr.aug.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==9){
            entryMgr.sep.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==10){
            entryMgr.oct.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==11){
            entryMgr.nov.removeAtIndex(CVDate(date: date!).day-1)
        }
        if(CVDate(date: date!).month==12){
            entryMgr.dec.removeAtIndex(CVDate(date: date!).day-1)
        }
    }
    
}

