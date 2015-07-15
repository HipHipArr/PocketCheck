//
//  SideBarTableViewController.swift
//  Cheapify 2.0
//
//  Created by Carol on 7/5/15.
//  Copyright (c) 2015 Hip Hip Array[]. All rights reserved.
//

import UIKit

protocol SideBarTableViewControllerDelegate{
    func sideBarControlDidSelectRow(indexPath:NSIndexPath)
}

class SideBarTableViewController: UITableViewController {
    
    var delegate:SideBarTableViewControllerDelegate?
    var tableData:Array<String> = []
    
    var color: UIColor!
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            // Configure the cell...
            
            chooseColor(tableData[indexPath.row])
            cell!.backgroundColor = color

            cell!.textLabel!.textColor = UIColor.darkTextColor()
            
            let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            
            cell!.selectedBackgroundView = selectedView
        }
        
        cell!.textLabel!.text = tableData[indexPath.row]
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sideBarControlDidSelectRow(indexPath)
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
    
}