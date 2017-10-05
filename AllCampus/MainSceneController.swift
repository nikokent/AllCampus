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
    @IBOutlet weak var scroller: UIScrollView!
    
    //Stores the offset of y position between each flier
    var yPos = 0.0
    var xOffset = 0.0
    var UIIconSize = 50.0
    var eventData = [postedEventData]()
   
    
    override func viewDidLoad() {
        
        //Gradient Implementation will stay in the background at the size of the scrollview
        //it will be a sublayer of the main view however!
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getLoveGradient()
        gradientLayer.frame = scroller.frame
        scroller.backgroundColor = .clear
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        //offset of object to the right
        //made to change based off of device screen width
        xOffset = Double(self.view.frame.width * 0.22)
        if(Double(self.view.frame.width) < 350){
            xOffset = Double(self.view.frame.width * 0.1)
        }
        //3 test objects
        eventData.append(postedEventData(title:"Kickback at our place", content: "Bring your own drinks. We are grilling burgers and have music setup.",eventTime: "Oct 27, 2017 8:30 pm",endTime: "Oct 27, 2017 11:30 pm" , tagData: 0))
        eventData.append(postedEventData(title:"VCEA Career Expo", content: "An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.",eventTime: "Oct 28, 2017 10:30 am",endTime: "Oct 28, 2017 3:30 pm" , tagData: 0))
        eventData.append(postedEventData(title:"Party At AKL!", content: "Full on rager at AKL tonight. Girls bring your friends! It'll be lit! 🔥", eventTime: "Oct 30, 2017 11:00 pm", endTime: "Oct 31, 2017 2:00 am" , tagData: 0))
        
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
        let image = UIImage(named: "Rectangle 1")
        let UIlineViewer = UIImageView(frame: CGRect(x: xOffset + 41, y: 117 + yPos, width: 200, height: 1.5))
        let UILineImage = UIImage(named: "Line 1")
        let labelHeader = UILabel(frame: CGRect(x: xOffset, y: 73 + yPos, width: 283, height: 50))
        let labelContent = UILabel(frame: CGRect(x: xOffset + 39, y: 170 + yPos, width: 200, height: 150))
        let labelTime = UILabel(frame: CGRect(x: xOffset + 39, y: 135 + yPos, width: 200, height: 80))
        var calendarImage = UIImage(named: "calendar-7")
        let calendarButton = UIButton(frame: CGRect(x: xOffset + 39, y: 320 + yPos, width: UIIconSize, height: UIIconSize))
        var mapImage = UIImage(named: "map-location")
        let mapButton = UIButton(frame: CGRect(x: xOffset + 115, y: 320 + yPos, width: UIIconSize, height: UIIconSize))
        
        //Design Attributes for all text
        labelHeader.text = data.title
        labelHeader.textColor = UIColor(hue: 211/360, saturation: 21/100, brightness: 53/100, alpha: 1.0)
        labelHeader.font = UIFont(name: "Helvetica Bold", size: 30)
        labelHeader.textAlignment = .center
        
        labelContent.text = data.content
        labelContent.textColor = UIColor(hue: 211/360, saturation: 21/100, brightness: 53/100, alpha: 1.0)
        labelContent.font = UIFont(name: "Helvetica", size: 15)
        labelContent.numberOfLines = 8
        labelContent.sizeToFit()
        labelContent.lineBreakMode = .byWordWrapping
        
        labelTime.text = data.eventTime
        labelTime.textColor = UIColor(hue: 5/360, saturation: 77/100, brightness: 75/100, alpha: 1.0)
        labelTime.font = UIFont(name: "Helvetica", size: 17)
        labelTime.sizeToFit()
        labelTime.textAlignment = .center
        
        
        //image resizing
        //UIIconsize is the same as the previously set width and height to avoid multiple images

        calendarImage = resizeImage(image: calendarImage!, targetSize: CGSize.init(width: UIIconSize, height: UIIconSize))
        mapImage = resizeImage(image: mapImage!, targetSize: CGSize.init(width: UIIconSize, height: UIIconSize))
        
        
        //button design and event selectors
        let eventHandler = ExternalEventHandler()
        calendarButton.backgroundColor = UIColor(patternImage: calendarImage!)
        calendarButton.tag = tag
        calendarButton.addTarget(self, action: #selector(addToCalendar(_:)), for: .touchUpInside)
        mapButton.backgroundColor = UIColor(patternImage: mapImage!)
        mapButton.addTarget(self, action: #selector(doStuff), for: .touchUpInside)
        
        
        
        //assign background image that will be the "flier" for each event. Users "Rectangle 1"
        container.backgroundColor = UIColor(patternImage: image!)
        UIlineViewer.backgroundColor = UIColor(patternImage: UILineImage!)
        
        //resizing the header to fit properly
        if(data.title.count > 13){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 25)
        }
        if(data.title.count > 16){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 20)
        }
        if(data.title.count > 22){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 18)
        }
        
        
        
        //adds all objects to the scroll view
        scroller.addSubview(container)
        scroller.addSubview(labelHeader)
        scroller.addSubview(labelContent)
        scroller.addSubview(UIlineViewer)
        scroller.addSubview(labelTime)
        scroller.addSubview(mapButton)
        scroller.addSubview(calendarButton)
        //Resize content size of UIScrollView
        //Reposition where next image would be
        yPos += 400
        self.scroller.contentSize = CGSize(width: 0,height: CGFloat(yPos + 100))
        
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
    
    @objc func addToCalendar(_ sender: UIButton) {
        //date formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        let StartDate = formatter.date(from: eventData[sender.tag].eventTime)
        let EndDate = formatter.date(from: eventData[sender.tag].endTime)
        
        //event handler from "externalEvents.swift"
        //sender.tag is given in loadview() and passed in at add object
        let eventHandler = ExternalEventHandler()
        eventHandler.addEventToCalendar(title: eventData[sender.tag].title, description: eventData[sender.tag].content, startDate: StartDate!, endDate: EndDate!, completion: nil)
        let alertcontroller = UIAlertController(title: eventData[sender.tag].title, message: "has been added to your calendar!\n\(eventData[sender.tag].eventTime)", preferredStyle: UIAlertControllerStyle.alert)
        alertcontroller.addAction(UIAlertAction(title: "close", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        self.present(alertcontroller, animated: true,completion: nil)
    }
    
    

}
