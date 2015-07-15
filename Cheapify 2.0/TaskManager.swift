//
//  TaskManager.swift
//  Cheapify 2.0
//
//  Created by Christine Wen on 7/1/15.
//  Copyright (c) 2015 Your Friend. All rights reserved.
//

import UIKit

var taskMgr: TaskManager = TaskManager()

struct Task {
    var event = "Name"
    var category = "Description"
    var price = "0.00"
    var tax = "0.00"
    var tip = "0.00"
}

class TaskManager: NSObject {
    
    var tasks = [Task]()
    
    func addTask(event: String, category: String, price: String, tax: String, tip: String){
        
        tasks.append(Task(event: event, category: category, price: price, tax: tax, tip: tip))
        
    }
    
    func removeTask(index:Int){
        
        tasks.removeAtIndex(index)
        
    }
    
    
}
