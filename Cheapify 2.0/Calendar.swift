//
//  Calendar.swift
//  Cheapify 2.0
//
//  Edited by Carol on 7/2/15.
//  Created by Eugene Mozharovsky on 23/03/15.
//  Copyright (c) 2015 GameApp. All rights reserved.
//

import UIKit


class Calendar: UIViewController {
    // MARK: - Properties
    @IBOutlet var calendarView: CVCalendarView!    //! operator means value can be accessed, even if assigned value is null.
    @IBOutlet var menuView: CVCalendarMenuView!    //
    @IBOutlet var monthLabel: UILabel! //The label that shows the current month.
    @IBOutlet var button2:UIButton!
    
    var dateClicked: String?
    var animationFinished = true    //Indicates whether the entire calendar has been loaded/drawn.
    
    // MARK: - Life cycle
    
    //Sets monthLabel's text to the month of the current date
    override func viewDidLoad() {
        super.viewDidLoad()
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        var todaysDate:NSDate = NSDate()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M-d-yyyy"// HH:mm"
        var DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        dateClicked = DateInFormat
        
        button2.layer.cornerRadius = 23.0
        button2.layer.borderWidth = 1.5
        
        configureButton()
    }
    
    //Updates the calendar and the menu.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
}

// MARK: - CVCalendarViewDelegate

extension Calendar: CVCalendarViewDelegate
{
    //Draws a gray circle around today's date
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    //If the user is on today's date, return true, otherwise return false
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let π = M_PI    //pi
        let ringSpacing: CGFloat = 3.0  //big value = small ring, small value = big ring
        let ringInsetWidth: CGFloat = 1.0  //big value = ring is closer to center, small value = ring is further from center
        let ringVerticalOffset: CGFloat = 1.0   //pos value = ring moves vertically up, neg value = ring moves vertically down
        var ringLayer: CAShapeLayer!    //creates a new layer to put the ring on
        let ringLineWidth: CGFloat = 4.0    //0 = no blue rings, pos value = ring is fatter, neg value = ring is skinnier and larger
        let ringLineColour: UIColor = .blueColor()  //sets the ring's color to blue
        
        var newView = UIView(frame: dayView.bounds) //the UI around a given date (the one selected, not necessarily today's date)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing    //The inner bound of the ring
        let radius: CGFloat = diameter / 2.0    //Diameter/2
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)  //Draws a rectangle
        
        ringLayer = CAShapeLayer()  //creates a new layer that will be used to draw the ring
        newView.layer.addSublayer(ringLayer)    //adds the ring layer to the UI
        
        ringLayer.fillColor = nil   // Sets the ring's fill to null
        ringLayer.lineWidth = ringLineWidth //Sets the ring's line width to ringLineWidth (defined in this method as a constant 4.0)
        ringLayer.strokeColor = ringLineColour.CGColor  //Sets the ring's color
        
        var ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth   //I'm not sure but I assume it dictates how far from the center of the circle the ring ends (inside diameter)
        
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)    //Draws rectangle around where the ring should be (inside of the rectangle rect referenced earlier in the group)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)    //Sets the center of the ring to the center of the rectangle ringRect
        let startAngle: CGFloat = CGFloat(-π/2.0)   //start angle is 270 degrees
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle   //end angle is 270 + 360 degrees
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)  //This entire section draws the ring
        
        ringLayer.path = ringPath.CGPath    //CG is different than UI so I presume that ringPath is a UI thing and it needs to be converted to CG
        ringLayer.frame = newView.layer.bounds  //Bounds for the ring??
        
        return newView  //returns the new UI with the new ring put in
    }
    
    //determines whether the date gets a blue ring (true) or not (false) and returns true 1/3 of the time, false 2/3 of the time
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        if (dayView.date == nil)
        {
            return false;
        }
        if(dayView.date.month==1){
            return entryMgr.jan[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==2){
            return entryMgr.feb[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==3){
            return entryMgr.mar[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==4){
            return entryMgr.apr[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==5){
            return entryMgr.may[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==6){
            return entryMgr.jun[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==7){
            return entryMgr.jul[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==8){
            return entryMgr.aug[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==9){
            return entryMgr.sep[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==10){
            return entryMgr.oct[dayView.date.day - 1] != "0";
        }
        if(dayView.date.month==11){
            return entryMgr.nov[dayView.date.day - 1] != "0";
        }
        return entryMgr.dec[dayView.date.day - 1] != "0";
    }
    
    @IBAction func btnClicked(sender : UIButton){
        if(dateClicked != nil){
            self.performSegueWithIdentifier("dayEntries", sender: self)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dayEntries" {
            var view = segue.destinationViewController as! DayEntries
            view.date = dateClicked
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
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
        else if (percent < 100){
            button2.backgroundColor = UIColor(red: CGFloat(246)/255, green: CGFloat(15)/255, blue: CGFloat(15)/255, alpha: 0.99999999999999);
        }
        else if (percent > 100){
            button2.backgroundColor = UIColor(red: CGFloat(0)/255, green: CGFloat(0)/255, blue: CGFloat(0)/255, alpha: 0.99999999999999);
        }
        button2.tintColor = UIColor.whiteColor()
    }

}


extension Calendar: CVCalendarViewDelegate {
    //returns .MonthView, which is a CalendarMode
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    //returns the first day of the week
    func firstWeekday() -> Weekday {
        return .Monday
    }
    
    
    
    //if a date is clicked, it prints it to the terminal
    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        var todaysDate:NSDate = NSDate()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M-d-yyyy"// HH:mm"
        var DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        dateClicked = dateFormatter.stringFromDate(date.convertedDate()!)
    }
    
    //updates the date (mainly the monthLabel)
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)   //inserts updatedMonthLabel where monthLabel was
        }
    }
    
    //I have no idea what this does, as far as I know it just returns true all the time but whatever
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    
    //returns true all the time
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
}

// MARK: - CVCalendarViewAppearanceDelegate

extension Calendar: CVCalendarViewAppearanceDelegate {
    
    //returns false all the time
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    //sets the space between days to 2
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - CVCalendarMenuViewDelegate

extension Calendar: CVCalendarMenuViewDelegate {
    // firstWeekday() has been already implemented.
}

// MARK: - IB Actions

extension Calendar {
    
    //toggles the current day view
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }
    
    /// Switch to WeekView mode.
    @IBAction func toWeekView(sender: AnyObject) {
        calendarView.changeMode(.WeekView)
    }
    
    /// Switch to MonthView mode.
    @IBAction func toMonthView(sender: AnyObject) {
        calendarView.changeMode(.MonthView)
    }
    
    //loads the previous view
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }
    
    //loads the next view
    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }
}

// MARK: - Convenience API Demo

extension Calendar{
    //toggles month view with month offset
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
}
