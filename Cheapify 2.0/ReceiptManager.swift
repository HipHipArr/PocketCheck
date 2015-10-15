//
//  ReceiptManager.swift
//  Cheapify 2.0
//
//  
//  Copyright (c) 2015 Hip Hip Array[]. All rights reserved.
//

import UIKit
import Foundation
import CoreData

var entryMgr: ReceiptManager = ReceiptManager()

class Entry: NSObject/*, NSCoding */{
    var event = "Name"
    var category = "Description"
    var price = "0.00"
    var tax = "0.00"
    var tip = "0.00"
    var date = "Not assigned"
    
    init(event: String, category: String, price: String, tax: String, tip: String, date: String){
        self.event = event
        self.category = category
        self.price = price
        self.tax = tax
        self.tip = tip
        self.date = date
    }
    
    /*func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(event, forKey: "event")
        encoder.encodeObject(category, forKey: "category")
        encoder.encodeObject(price, forKey: "price")
        encoder.encodeObject(tax, forKey: "tax")
        encoder.encodeObject(tip, forKey: "tip")
        encoder.encodeObject(date, forKey: "date")
    }
    
    required init(coder aDecoder: NSCoder) {
        if let event = aDecoder.decodeObjectForKey("event") as? String{
            self.event = event
        }
        if let category = aDecoder.decodeObjectForKey("category") as? String{
            self.category = category
        }
        if let price = aDecoder.decodeObjectForKey("price") as? String{
            self.price = price
        }
        if let tax = aDecoder.decodeObjectForKey("tax") as? String{
            self.tax = tax
        }
        if let tip = aDecoder.decodeObjectForKey("tip") as? String{
            self.tip = tip
        }
        if let date = aDecoder.decodeObjectForKey("date") as? String{
            self.date = date
        }
    }*/
}

class Info: NSObject{
    var total = 0.00
    var tFood = 0.00
    var tTran = 0.00
    var tTrav = 0.00
    var tEnte = 0.00
    var tOthe = 0.00
    var tPers = 0.00
    var tBusi = 0.00
    var budget = 100.00
    
    init(total: Double, tFood: Double, tTran: Double, tTrav: Double, tEnte: Double, tOthe: Double, tPers: Double, tBusi: Double, budget: Double){
        self.total = total
        self.tFood = tFood
        self.tTran = tTran
        self.tTrav = tTrav
        self.tEnte = tEnte
        self.tOthe = tOthe
        self.tPers = tPers
        self.tBusi = tBusi
        self.budget = budget
    }
}

class ReceiptManager: NSObject/*, NSCoding */{
    
    var entries = [NSManagedObject]()
    
    var jan = [String]()
    var feb = [String]()
    var mar = [String]()
    var apr = [String]()
    var may = [String]()
    var jun = [String]()
    var jul = [String]()
    var aug = [String]()
    var sep = [String]()
    var oct = [String]()
    var nov = [String]()
    var dec = [String]()
    
    var tempArr = [NSManagedObject]()
    
    var categoryname: String!
    
    var moneyinfo = [NSManagedObject]()
    
    var total = 0.00
    
    var tFood = 0.00
    
    var tTran = 0.00
    
    var tTrav = 0.00
    
    var tEnte = 0.00
    
    var tOthe = 0.00
    
    var tPers = 0.00
    
    var tBusi = 0.00
    
    var budget = 100.00
    
    /*func encodeWithCoder(encoder: NSCoder) {
       // encoder.encodeObject(entries, forKey: "entries")
        encoder.encodeInteger(entries.count, forKey: "count")
        for index in 0 ..< entries.count {
            encoder.encodeObject( entries[index] )
        }
        /*encoder.encodeInteger(someInts.count, forKey: "count2")
        for index in 0 ..< someInts.count {
            encoder.encodeObject( someInts[index] )
        }*/
        encoder.encodeObject(total, forKey: "total")
        encoder.encodeObject(tFood, forKey: "tFood")
        encoder.encodeObject(tTran, forKey: "tTran")
        encoder.encodeObject(tTrav, forKey: "tTrav")
        encoder.encodeObject(tEnte, forKey: "tEnte")
        encoder.encodeObject(tOthe, forKey: "tOthe")
        encoder.encodeObject(tPers, forKey: "tPers")
        encoder.encodeObject(tBusi, forKey: "tBusi")
        encoder.encodeObject(budget, forKey: "budget")
    }
    
    required init(coder aDecoder: NSCoder) {
        let nbCounter = aDecoder.decodeIntegerForKey("countKey")
        for index in 0 ..< nbCounter {
            if var entry = aDecoder.decodeObject() as? Entry{
                entries.append(entry)
            }
        }
        
        /*let nbCounter2 = aDecoder.decodeIntegerForKey("countKey2")
        for index in 0 ..< nbCounter2 {
            if var string = aDecoder.decodeObject() as? String{
                someInts.append(string)
            }
        }*/
        
        if let total = aDecoder.decodeObjectForKey("total") as? Double{
            self.total = total
        }
        if let tFood = aDecoder.decodeObjectForKey("tFood") as? Double{
            self.tFood = tFood
        }
        if let tTran = aDecoder.decodeObjectForKey("tTran") as? Double{
            self.tTran = tTran
        }
        if let tTrav = aDecoder.decodeObjectForKey("tTrav") as? Double{
            self.tTrav = tTrav
        }
        if let tEnte = aDecoder.decodeObjectForKey("tEnte") as? Double{
            self.tEnte = tEnte
        }
        if let tOthe = aDecoder.decodeObjectForKey("tOthe") as? Double{
            self.tOthe = tOthe
        }
        if let tPers = aDecoder.decodeObjectForKey("tPers") as? Double{
            self.tPers = tPers
        }
        if let tBusi = aDecoder.decodeObjectForKey("tBusi") as? Double{
            self.tBusi = tBusi
        }
        if let budget = aDecoder.decodeObjectForKey("budget") as? Double{
            self.budget = budget
        }
    }
    
    override init() {
        
    }
    
    func addEntry(event: String, category: String, price: String, tax: String, tip: String, date: String){
        
        entries.append(Entry(event: event, category: category, price: price, tax: tax, tip: tip, date: date))
        
    }*/
    func saveName(){
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Info",
            inManagedObjectContext:
            managedContext)
        
        let info = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        info.setValue(total, forKey: "total")
        info.setValue(tFood, forKey: "tFood")
        info.setValue(tTran, forKey: "tTran")
        info.setValue(tTrav, forKey: "tTrav")
        info.setValue(tEnte, forKey: "tEnte")
        info.setValue(tOthe, forKey: "tOthe")
        info.setValue(tPers, forKey: "tPers")
        info.setValue(tBusi, forKey: "tBusi")
        info.setValue(budget, forKey: "budget")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        //5
        moneyinfo.append(info)
    }
    
}
