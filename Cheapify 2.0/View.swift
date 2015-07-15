//
//  View.swift
//  Cheapify 2.0
//
//  Created by loaner on 7/8/15.
//  Copyright (c) 2015 Your Friend. All rights reserved.
//

import UIKit

class View: UIImageView {

    var bgImage: UIImage!
    
    func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }
    
    func setup(){
        self.bgImage = chooseImage(entryMgr.categoryname)
    }
    
    func chooseImage (cat: String) -> UIImage {
        if(cat == "Food")
        {
            return UIImage(named: "food.jpg")!
        }
        else if(cat == "Personal")
        {
            return UIImage(named: "personal.jpg")!
        }
        else if(cat == "Travel")
        {
            return UIImage(named: "travel.jpg")!
        }
        else if(cat == "Transportation")
        {
            return UIImage(named: "transportation.jpg")!
        }
        else if(cat == "Business")
        {
            return UIImage(named: "business.jpg")!
        }
        else if(cat == "Entertainment")
        {
            return UIImage(named: "entertainment.jpg")!
        }
        return UIImage(named: "other.jpg")!
    }
    
}
