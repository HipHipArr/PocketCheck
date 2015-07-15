//
//  AddEntry.swift
//  Cheapify 2.0
//
//  Created by Carol on 7/1/15.
//  Designed by Maitreyee, Lauren on 7/1/15
//  Copyright (c) 2015 Hip Hip Array[]. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class AddEntry: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    //@IBOutlet weak var textView: UITextView!
    //@IBOutlet weak var findTextField: UITextField!
    //@IBOutlet weak var replaceTextField: UITextField!
    //@IBOutlet weak var topMarginConstraint: NSLayoutConstraint!
    
    var activityIndicator:UIActivityIndicatorView!
    var originalTopMargin:CGFloat!
    
    @IBOutlet var txtEvent: UITextField!
    @IBOutlet var txtPrice: UITextField!
    @IBOutlet var txtTax: UITextField!
    @IBOutlet var txtTip: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var camerabutton: UIButton!
    
    var viewController: ViewController!
    
    var dataSource = ["Food", "Personal", "Travel", "Transportation", "Business", "Entertainment", "Other"]
    
    var val: String = ""
    
    var str: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        val = dataSource[0]
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.view.backgroundColor = UIColor(red: CGFloat(255)/255, green: CGFloat(224)/255, blue: CGFloat(193)/255, alpha: 0.99);
    }
    
    @IBAction func btnAddEntry(sender : UIButton){
        //add record
        var todaysDate: NSDate = NSDate()
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M-d-yyyy"// HH:mm"
        var DateInFormat: String = dateFormatter.stringFromDate(todaysDate)
        //entryMgr.addEntry(txtEvent.text, category: val, price: txtPrice.text, tax: txtTax.text, tip: txtTip.text, date: DateInFormat)
        //  Method created by Amanda on 7/1/15
        //  Copyright (c) 2015 Hip Hip Array. All rights reserved.
        var startIndex = advance(txtPrice.text.startIndex, 0)
        var endIndex = advance(txtPrice.text.endIndex, 0)
        var range = startIndex..<endIndex
        var myNewString = txtPrice.text.substringWithRange(range)
        entryMgr.total = entryMgr.total + (myNewString as NSString).doubleValue
        self.subTotal(false)
        viewController.label.text = "Total: $"+entryMgr.total.description
        //dismiss keyboard and reset fields
        
        saveName(txtEvent.text, category: val, price: txtPrice.text, tax: txtTax.text, tip: txtTip.text, date: DateInFormat)
        entryMgr.saveName()
        self.view.endEditing(true)
        txtEvent.text = ""
        val = dataSource[0]
        txtPrice.text = ""
        txtTax.text = ""
        txtTip.text = ""
    }
    
    func saveName(event: String, category: String, price: String, tax: String, tip: String, date: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Entry",
            inManagedObjectContext:
            managedContext)
        
        let entry = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        entry.setValue(event, forKey: "event")
        entry.setValue(price, forKey: "price")
        entry.setValue(category, forKey: "category")
        entry.setValue(tax, forKey: "tax")
        entry.setValue(tip, forKey: "tip")
        entry.setValue(date, forKey: "date")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        entryMgr.entries.append(entry)
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent!){
        self.view.endEditing(true)
    }
    
    //  sFunction written by Mira
    //  Copyright (c) 2015 Hip Hip Array. All rights reserved.
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if (textField === txtEvent)
        {
            txtEvent.resignFirstResponder()
            pickerView.becomeFirstResponder()
        }
        if (textField === txtPrice)
        {
            txtPrice.resignFirstResponder()
            txtTax.becomeFirstResponder()
        }
        if (textField === txtTax)
        {
            txtTax.resignFirstResponder()
            txtTip.becomeFirstResponder()
        }
        if (textField === txtTip)
        {
            txtTip.resignFirstResponder()
        }
        return true
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //  Designed by Maitreyee, Lauren on 7/1/15
        //  Copyright (c) 2015 Hip Hip Array[]. All rights reserved.
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
        var startIndex = advance(txtPrice.text.startIndex, 0)
        var endIndex = advance(txtPrice.text.endIndex, 0)
        var range = startIndex..<endIndex
        var myNewString = txtPrice.text.substringWithRange(range)
        var subtractVal = (myNewString as NSString).doubleValue
        if(subtract){
            subtractVal = 0-subtractVal;
        }
        if(val == "Food"){
            entryMgr.tFood = entryMgr.tFood + subtractVal
        }
        if(val == "Transportation"){
            entryMgr.tTran = entryMgr.tTran + subtractVal
        }
        
        if(val == "Other"){
            entryMgr.tOthe = entryMgr.tOthe + subtractVal
        }
        
        if(val == "Business"){
            entryMgr.tBusi = entryMgr.tBusi + subtractVal
        }
        
        if(val == "Personal"){
            entryMgr.tPers = entryMgr.tPers + subtractVal
        }
        
        if(val == "Entertainment"){
            entryMgr.tEnte = entryMgr.tEnte + subtractVal
        }
        if(val == "Travel"){
            entryMgr.tTrav = entryMgr.tTrav + subtractVal
        }
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        // 1
        view.endEditing(true)
        moveViewDown()
        
        // 2
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        // 3
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                style: .Default) { (alert) -> Void in
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .Camera
                    self.presentViewController(imagePicker,
                        animated: true,
                        completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
            style: .Default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker,
                    animated: true,
                    completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        // 5
        let cancelButton = UIAlertAction(title: "Cancel",
            style: .Cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        
        // 6
        presentViewController(imagePickerActionSheet, animated: true,
            completion: nil)
    }
    
    @IBAction func swapText(sender: AnyObject) {
        // 1
        //if textView.text.isEmpty {
            //return
        //}
        
        // 2
        /*textView.text =
            textView.text.stringByReplacingOccurrencesOfString(findTextField.text,
                withString: replaceTextField.text, options: nil, range: nil)
        
        // 3
        findTextField.text = nil
        replaceTextField.text = nil*/
        
        // 4
        view.endEditing(true)
        moveViewDown()
        
    }
    
    @IBAction func sharePoem(sender: AnyObject) {
        // 1
        //if textView.text.isEmpty {
            //return
        //}
        
        // 2
        //let activityViewController = UIActivityViewController(activityItems:
            //[textView.text], applicationActivities: nil)
        
        // 3
        let excludeActivities = [
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo]
        //activityViewController.excludedActivityTypes = excludeActivities
        
        // 4
        //presentViewController(activityViewController, animated: true,
            //completion: nil)
    }
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        //do image contrast and filtering here
        var scaledSize = CGSizeMake(maxDimension, maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    // Activity Indicator methods
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    
    // The remaining methods handle the keyboard resignation/
    // move the view so that the first responders aren't hidden
    
    func moveViewUp() {
      /*  if topMarginConstraint.constant != originalTopMargin {
            return
        }
        
        topMarginConstraint.constant -= 135
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })*/
    }
    
    func moveViewDown() {
        /*if topMarginConstraint.constant == originalTopMargin {
            return
        }
        
        topMarginConstraint.constant = originalTopMargin
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })*/
        
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
        moveViewDown()
    }
    
    func performImageRecognition(image: UIImage) {
        // 1
        let tesseract = G8Tesseract()
        
        // 2
        tesseract.language = "eng+fra"
        
        // 3
        tesseract.engineMode = .TesseractCubeCombined
        
        // 4
        tesseract.pageSegmentationMode = .Auto
        
        // 5
        tesseract.maximumRecognitionTime = 60.0
        
        // 6
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        // 7
        //textView.text = tesseract.recognizedText
        //textView.editable = true
        
        str = tesseract.recognizedText
        
        processText()
        
        // 8
        removeActivityIndicator()
    }
    
    func processText(){
        if((str.lowercaseString as NSString).containsString("total")){
            var range = str.lowercaseString.rangeOfString("total", options: .BackwardsSearch)
            var index: Int = distance(str.startIndex, range!.startIndex)
            var price: String = ""
            var found: Bool = false
            let myArrayFromString = Array(str)
            while index<count(str) && !found {
                var num = str[index].toInt()
                if num != nil {
                    found = true
                }
                else{
                    index = index+1
                }
            }
            while index<count(str) {
                var num = str[index].toInt()
                if num != nil {
                    price = price+str[index]
                }
                else{
                    break
                }
                index = index + 1
            }
            txtPrice.text = price
            println(price)
        }
        if((str.lowercaseString as NSString).containsString("tip")){
            var range = str.lowercaseString.rangeOfString("tip", options: .BackwardsSearch)
            var index: Int = distance(str.startIndex, range!.startIndex)
            var price: String = ""
            var found: Bool = false
            let myArrayFromString = Array(str)
            while index<count(str) && !found {
                var num = str[index].toInt()
                if num != nil {
                    found = true
                }
                else{
                    index = index+1
                }
            }
            while index<count(str) {
                var num = str[index].toInt()
                if str[index]=="." || num != nil {
                    price.append(myArrayFromString[index])
                }
                else{
                    break
                }
                index = index + 1
            }
            txtTip.text = price
            println(price)
        }
        if((str.lowercaseString as NSString).containsString("tax")){
            var range = str.lowercaseString.rangeOfString("tax", options: .BackwardsSearch)
            var index: Int = distance(str.startIndex, range!.startIndex)
            var price: String = ""
            var found: Bool = false
            let myArrayFromString = Array(str)
            while index<count(str) && !found {
                var num = str[index].toInt()
                if num != nil {
                    found = true
                }
                else{
                    index = index+1
                }
            }
            while index<count(str) {
                var num = str[index].toInt()
                if num != nil {
                    price.append(myArrayFromString[index])
                }
                else{
                    break
                }
                index = index + 1
            }
            println(price)
            txtTax.text = price
        }
    }
}

extension AddEntry: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        moveViewUp()
    }
    
    @IBAction func textFieldEndEditing(sender: AnyObject) {
        view.endEditing(true)
        moveViewDown()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        moveViewDown()
    }
}

extension AddEntry: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
            let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
            
            addActivityIndicator()
            
            dismissViewControllerAnimated(true, completion: {
                self.performImageRecognition(scaledImage)
            })
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}
