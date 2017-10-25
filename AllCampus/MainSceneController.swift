//
//  MainSceneController.swift
//  AllCampus
//
//  Created by Niko Kent on 10/2/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit
import EventKit

class MainSceneController: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var labelEventType: UILabel!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var BottomMenuBar: UIImageView!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var SchoolBtn: UIButton!
    @IBOutlet weak var partyBTN: UIButton!
    @IBOutlet weak var GreekBtn: UIButton!
    @IBOutlet weak var MiscBTN: UIButton!
    
    //Stores the offset of y position between each flier
    var yPos = 0.0
    var xOffset = 0.0
    var UIIconSize = 186.0
    var eventData = [postedEventData]()
    var totalLayers:UInt32 = 0
    var xOffsetButtons: CGFloat = 0.0
    override func viewDidLoad() {
        adjustButtons()
        allBtn.frame.origin.x += 20
        xOffsetButtons = 2
        //Gradient Implementation will stay in the background at the size of the scrollview
        //it will be a sublayer of the main view however!
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getSweetMorningGradient()
        gradientLayer.frame = scroller.bounds
        scroller.backgroundColor = .clear
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        labelEventType.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        labelEventType.frame = CGRect(x: 0, y: Double(self.mainView.frame.height/2), width: 50, height: 40)
        labelEventType.text = "All Events"
        labelEventType.textColor = .white
        labelEventType.sizeToFit()
        
        //offset of object to the right
        //made to change based off of device screen width
        //xOffset = Double(self.view.frame.width * 0.22)
       // if(Double(self.view.frame.width) < 350){
        xOffset = Double(self.view.frame.width - 290)
       // }
        print(self.view.frame.width)
        if(self.view.frame.width <= 330){
            allBtn.isHidden = true
            SchoolBtn.isHidden = true
            partyBTN.isHidden = true
            GreekBtn.isHidden = true
            MiscBTN.isHidden = true
        }
        //bottom Menu Bar styling
        BottomMenuBar.backgroundColor = UIColor.black
        BottomMenuBar.addBlurEffect()
       
        
        //Builds the list of events from our EventBuilder class
        var builder = EventBuilder()
        eventData = builder.testEvents()
        
        //bubble sort for eventData sorting by date, I recognize n^2 is not optimal time, so this is temporary
        var outer = 0
        var inner = 0
        for _ in 1...eventData.count{
            inner = 0
            for _ in 1...eventData.count{
                
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy h:mm a"
                let date1 = formatter.date(from: eventData[inner].eventTime)
                let date2 = formatter.date(from: eventData[outer].eventTime)
                if(date2! < date1!){
                    var temp = eventData[inner]
                    eventData[inner] = eventData[outer]
                    eventData[outer] = temp
                }
                
                inner += 1
            }
            outer += 1
        }
        //loop index in for-in loop
        //loop iterates through event data and adds each event to scrollView
        var i = 0
        for _ in 1...eventData.count{
            eventData[i].tagData = i
            addObject(data: eventData[i], tag: i)
            i += 1
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function will add each container for each event and pass in all necessary info regarding the event
    func addObject(data: postedEventData, tag: Int)  {
        //UI objects
        var container = UIImageView(frame: CGRect(x:xOffset, y:50 + yPos,width: 283, height: 360))
        //let image = UIImage(named: "Rectangle 1")
        let UIlineViewer = UIImageView(frame: CGRect(x: xOffset + 41, y: 117 + yPos, width: 200, height: 1.5))
        let UILineImage = UIImage(named: "Line 1")
        let labelHeader = UILabel(frame: CGRect(x: xOffset, y: 73 + yPos, width: 283, height: 50))
        let labelContent = UILabel(frame: CGRect(x: xOffset + 45, y: 160 + yPos, width: 200, height: 100))
        let labelTime = UILabel(frame: CGRect(x: xOffset + 52, y: 135 + yPos, width: 200, height: 80))
        var calendarImage = UIImage(named: "purpleButton")
        let calendarButton = UIButton(frame: CGRect(x: xOffset + 50, y: 300 + yPos, width: UIIconSize, height: 33))
        var mapImage = UIImage(named: "blueButton")
        let mapButton = UIButton(frame: CGRect(x: xOffset + 50, y: 340 + yPos, width: UIIconSize, height: 33))
        let infoButton = UIButton(frame: CGRect(x: xOffset + 50, y: 260 + yPos, width: UIIconSize, height: 33))
        //Design Attributes for all text
        labelHeader.text = data.title
        labelHeader.textColor = UIColor(hue: 246/360, saturation: 11/100, brightness: 47/100, alpha: 1.0)
    
        labelHeader.font = UIFont(name: "Helvetica Bold", size: 30)
        labelHeader.textAlignment = .center
        
        labelContent.text = data.content
        labelContent.textColor = UIColor(hue: 211/360, saturation: 15/100, brightness: 70/100, alpha: 1.0)
        labelContent.font = UIFont(name: "Helvetica", size: 15)
        labelContent.numberOfLines = 8
        //labelContent.sizeToFit()
        labelContent.lineBreakMode = .byTruncatingTail
        
        labelTime.text = data.eventTime
        labelTime.textColor = UIColor(hue: 211/360, saturation: 15/100, brightness: 70/100, alpha: 1.0)
        labelTime.font = UIFont(name: "Helvetica", size: 17)
        labelTime.sizeToFit()
        labelTime.textAlignment = .center
        
        
        //image resizing
        //UIIconsize is the same as the previously set width and height to avoid multiple images

        //calendarImage = resizeImage(image: calendarImage!, targetSize: CGSize.init(width: UIIconSize, height: 40))
        //mapImage = resizeImage(image: mapImage!, targetSize: CGSize.init(width: UIIconSize, height: UIIconSize))
        
        
        //button styling and event selectors
        let eventHandler = ExternalEventHandler()
        calendarButton.backgroundColor = UIColor.clear
        calendarButton.layer.cornerRadius = 15
        calendarButton.layer.borderWidth = 1
        calendarButton.layer.borderColor = UIColor(hue: 0.825, saturation: 0.4, brightness: 0.7, alpha: 1.0).cgColor
        calendarButton.showsTouchWhenHighlighted = true
        calendarButton.setTitleColor(UIColor(hue: 0.825, saturation: 0.4, brightness: 0.7, alpha: 0.6), for: .highlighted)
        calendarButton.tag = tag
        calendarButton.setTitle("Add to Calendar", for: .normal)
        calendarButton.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        calendarButton.setTitleColor(UIColor(hue: 0.825, saturation: 0.4, brightness: 0.7, alpha: 1.0), for: .normal)
        calendarButton.addTarget(self, action: #selector(addToCalendar(_:)), for: .touchUpInside)
        mapButton.backgroundColor = UIColor.clear
        mapButton.layer.cornerRadius = 15
        mapButton.layer.borderWidth = 1
        mapButton.layer.borderColor = UIColor(hue: 0.6278, saturation: 0.68, brightness: 0.86, alpha: 1.0).cgColor
        mapButton.addTarget(self, action: #selector(openMaps(_:)), for: .touchUpInside)
        mapButton.tag = tag
        mapButton.showsTouchWhenHighlighted = true
        mapButton.setTitleColor(UIColor(hue: 0.6278, saturation: 0.68, brightness: 0.86, alpha: 0.6), for: .highlighted)
        mapButton.setTitle("Open in Maps", for: .normal)
        mapButton.titleLabel?.font = UIFont(name: "Helvetica",size: 17)
        mapButton.setTitleColor(UIColor(hue: 0.6278, saturation: 0.68, brightness: 0.86, alpha: 1.0), for: .normal)
        infoButton.backgroundColor = UIColor.clear
        infoButton.layer.cornerRadius = 15
        infoButton.layer.borderWidth = 1
        infoButton.layer.borderColor = UIColor(hue: 211/360, saturation: 15/100, brightness: 70/100, alpha: 1.0).cgColor
        infoButton.addTarget(self, action: #selector(moreInfo(_:)), for: .touchUpInside)
        infoButton.tag = tag
        infoButton.showsTouchWhenHighlighted = true
        infoButton.setTitleColor(UIColor(hue: 211/360, saturation: 15/100, brightness: 70/100, alpha: 1.0), for: .highlighted)
        infoButton.setTitle("More Info", for: .normal)
        infoButton.titleLabel?.font = UIFont(name: "Helvetica",size: 17)
        infoButton.setTitleColor(UIColor(hue: 211/360, saturation: 15/100, brightness: 70/100, alpha: 1.0), for: .normal)
        
        
        
        //assign background image that will be the "flier" for each event. Users "Rectangle 1"
        //container.backgroundColor = UIColor(patternImage: image!)
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 25
        container.layer.masksToBounds = false
        container.layer.shadowRadius = 5
        container.layer.shadowOffset = CGSize(width: 5, height: 10)
        container.layer.shadowOpacity = 0.5
    
        UIlineViewer.backgroundColor = UIColor(patternImage: UILineImage!)
        
        //resizing the header to fit properly
        if(data.title.count > 13){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 25)
        }
        if(data.title.count > 16){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 22)
        }
        if(data.title.count > 22){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 20)
        }
        
        
        
        //adds all objects to the scroll view
        scroller.addSubview(container)
        scroller.addSubview(labelHeader)
        scroller.addSubview(labelContent)
        scroller.addSubview(UIlineViewer)
        scroller.addSubview(labelTime)
        scroller.addSubview(mapButton)
        scroller.addSubview(infoButton)
        scroller.addSubview(calendarButton)
        //Resize content size of UIScrollView
        //Reposition where next image would be
        yPos += 400
        self.scroller.contentSize = CGSize(width: 0,height: CGFloat(yPos + 100))
        
    }
    
    //Adds all objects to the screen of specific type
    func buildObjects(type: Int){
        print("BUILDING")
        yPos = 0
        var i = 0
        if(type == 0){
            for _ in 1...eventData.count{
                    eventData[i].tagData = i
                    addObject(data: eventData[i], tag: i)
                    i += 1
                
            }
        }
        else{
        for _ in 1...eventData.count{
            print(eventData[i].EventType)
                if(eventData[i].EventType == type){
                    eventData[i].tagData = i
                    addObject(data: eventData[i], tag: i)
                    print("type is \(type)")
                }
            i += 1
            }
        }
    }
    
    //Removes all objects
    func removeObjects(){
        while let subview = scroller.subviews.last {
            subview.removeFromSuperview()
        }
    }
    
    
    
    //function to resize image!
    //Taken from stack overflow
    //stackoverflow.com/questions/31314412/how-to-resize-image-in-swift
    //Since @KiritModi 's answer is from 2015, this is the Swift 3.0's version:
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //test function for buttons to call alerts
    //#selector calls need an "@objc" objective-c function
    @objc func doStuff() {
        let alertcontroller = UIAlertController(title: "Clicked!", message: "Close?", preferredStyle: UIAlertControllerStyle.alert)
        alertcontroller.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        self.present(alertcontroller, animated: true,completion: nil)
    }
    
    //Function to see all info regarding the event
    //uses an alert window to display everything (Seemed like a simple way to implement 🤷🏻‍♂️)
    @objc func moreInfo(_ sender: UIButton) {
        var fullMessage = "Time:\n" + eventData[sender.tag].eventTime + " to " + eventData[sender.tag].endTime + "\n\nDescription:\n" + eventData[sender.tag].content + "\n\nLocation:\n" + eventData[sender.tag].location
        let alertcontroller = UIAlertController(title: eventData[sender.tag].title, message: fullMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertcontroller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            //self.removeObjects()
        }))
        self.present(alertcontroller, animated: true,completion: nil)
    }
    
    //Function to open apple maps to the location assigned for the event
    //Uses a native api for maps.apple.com which opens the iOS native Maps app
    @objc func openMaps(_ sender: UIButton) {
        //safe string is needed to remove any pre insterted commas and replace spaces with commas
        //reason for this is due to needing a url safe web address
        var safeString = eventData[sender.tag].location.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: " ", with: ",")
        var address = "http://maps.apple.com/?address=" + safeString
        UIApplication.shared.openURL(URL(string: address)!)
    }
    
    
    //Function to add actual event to the ios calendar
    //makes use of sender for UIButton which is essential to specify which event by ID tag
    //              so we can make the appropriate changes to the calendar.
    //This function requires import EventKit
    @objc func addToCalendar(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        //in the situation and event was added then deleted from calendar
        //and the user wants to re-add it, then the user is given that option
        var redo = false
        if(defaults.bool(forKey: eventData[sender.tag].title + eventData[sender.tag].eventTime) == true){
            var fullMessage = eventData[sender.tag].title + " has already been added to your Calendar!\nWould you like us to schedule this again?"
            let alertcontroller = UIAlertController(title: "Hold up!", message: fullMessage, preferredStyle: UIAlertControllerStyle.alert)
            alertcontroller.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                defaults.set(true, forKey: self.eventData[sender.tag].title + self.eventData[sender.tag].eventTime)
                self.eventData[sender.tag].hasBeenAdded = true //Let the program know the event has been added to calendar
                //date formatter
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy h:mm a"
                let StartDate = formatter.date(from: self.eventData[sender.tag].eventTime)
                let EndDate = formatter.date(from: self.eventData[sender.tag].endTime)
                
                //event handler from "externalEvents.swift"
                //sender.tag is given in loadview() and passed in at add object
                let eventHandler = ExternalEventHandler()
                eventHandler.addEventToCalendar(title: self.eventData[sender.tag].title, description: self.eventData[sender.tag].content + "\n" + "Location: " + self.eventData[sender.tag].location, startDate: StartDate!, endDate: EndDate!, completion: nil)
                let alertcontroller = UIAlertController(title: self.eventData[sender.tag].title, message: "has been added to your calendar!\n\(self.eventData[sender.tag].eventTime)", preferredStyle: UIAlertControllerStyle.alert)
                alertcontroller.addAction(UIAlertAction(title: "close", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                }))
                self.present(alertcontroller, animated: true,completion: nil)
            }))
            alertcontroller.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                redo = false
            }))
            self.present(alertcontroller, animated: true,completion: nil)
        }
        //if uses requests a readd or if event has never been added
        //then follows adding event to calendar
        else if(redo == true || eventData[sender.tag].hasBeenAdded == false){
            //Defaults saves in the device that the event with a certain title and date has already been added before!
        defaults.set(true, forKey: eventData[sender.tag].title + eventData[sender.tag].eventTime)
        eventData[sender.tag].hasBeenAdded = true //Let the program know the event has been added to calendar
        //date formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        let StartDate = formatter.date(from: eventData[sender.tag].eventTime)
        let EndDate = formatter.date(from: eventData[sender.tag].endTime)
        
        //event handler from "externalEvents.swift"
        //sender.tag is given in loadview() and passed in at add object
        let eventHandler = ExternalEventHandler()
            eventHandler.addEventToCalendar(title: eventData[sender.tag].title, description: eventData[sender.tag].content + "\n" + "Location: " + eventData[sender.tag].location, startDate: StartDate!, endDate: EndDate!, completion: nil)
        let alertcontroller = UIAlertController(title: eventData[sender.tag].title, message: "has been added to your calendar!\n\(eventData[sender.tag].eventTime)", preferredStyle: UIAlertControllerStyle.alert)
        alertcontroller.addAction(UIAlertAction(title: "close", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        self.present(alertcontroller, animated: true,completion: nil)
        }
    }
    
    
    //**********************************Filter Event Type***************************************
    @IBAction func AllSelected(_ sender: Any) {
        removeObjects()
        buildObjects(type: 0)
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getSweetMorningGradient()
        gradientLayer.frame = scroller.bounds
        scroller.backgroundColor = .clear
        totalLayers += 1
        self.view.layer.insertSublayer(gradientLayer, at: totalLayers)
        adjustButtons()
        allBtn.frame.origin.x += 20
        
    }
    @IBAction func schoolSelected(_ sender: Any) {
        removeObjects()
        buildObjects(type: 1)
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getHoneydewGradient()
        gradientLayer.frame = scroller.bounds
        scroller.backgroundColor = .clear
        totalLayers += 1
        self.view.layer.insertSublayer(gradientLayer, at: totalLayers)
        adjustButtons()
        SchoolBtn.frame.origin.x += 15
        
    }
    @IBAction func PartiesSelected(_ sender: Any) {
        removeObjects()
        buildObjects(type: 2)
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getLoveGradient()
        gradientLayer.frame = scroller.bounds
        scroller.backgroundColor = .clear
        totalLayers += 1
        self.view.layer.insertSublayer(gradientLayer, at: totalLayers)
        adjustButtons()
        partyBTN.frame.origin.x += 15
    }
    @IBAction func GreekSelected(_ sender: Any) {
        removeObjects()
        buildObjects(type: 3)
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getRoseGradient()
        gradientLayer.frame = scroller.bounds
        scroller.backgroundColor = .clear
        totalLayers += 1
        self.view.layer.insertSublayer(gradientLayer, at: totalLayers)
        adjustButtons()
        GreekBtn.frame.origin.x += 15
    }
    @IBAction func MiscSelected(_ sender: Any) {
        removeObjects()
        buildObjects(type: 4)
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getIbizaSunset()
        gradientLayer.frame = scroller.bounds
        scroller.backgroundColor = .clear
        totalLayers += 1
        self.view.layer.insertSublayer(gradientLayer, at: totalLayers)
        adjustButtons()
        MiscBTN.frame.origin.x += 15
    }
    
    //adjusts buttons back into original sliding position
    func adjustButtons(){
        allBtn.frame.origin.x = xOffsetButtons
        allBtn.contentHorizontalAlignment = .left
        SchoolBtn.frame.origin.x = xOffsetButtons
        SchoolBtn.contentHorizontalAlignment = .left
        partyBTN.frame.origin.x = xOffsetButtons
        partyBTN.contentHorizontalAlignment = .left
        GreekBtn.frame.origin.x = xOffsetButtons
        GreekBtn.contentHorizontalAlignment = .left
        MiscBTN.frame.origin.x = xOffsetButtons
        MiscBTN.contentHorizontalAlignment = .left
    }
    //**********************************End of Filter Event Type***************************************
    
    
    
}
