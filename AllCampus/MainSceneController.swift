//
//  MainSceneController.swift
//  AllCampus
//
//  Created by Niko Kent on 10/2/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit

class MainSceneController: UIViewController {
    @IBOutlet weak var scroller: UIScrollView!
    
    //Stores the offset of y position between each flier
    var yPos = 0.0
    
    override func viewDidLoad() {
        
        //3 test objects
        addObject(title:"Kickback at our place", content: "Bring your own drinks. We are grilling burgers and have music setup.")
        addObject(title:"VCEA Career Expo", content: "An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.")
        addObject(title:"Party At AKL!", content: "Full on rager at AKL tonight. Girls bring your friends! It'll be lit! 🔥")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function will add each container for each event and pass in all necessary info regarding the event
    func addObject(title: String, content: String)  {
        //UI objects
        var container = UIImageView(frame: CGRect(x:40, y:50 + yPos,width: 283, height: 360))
        let image = UIImage(named: "Rectangle 1")
        let labelHeader = UILabel(frame: CGRect(x: 66, y: 73 + yPos, width: 360, height: 50))
        let labelContent = UILabel(frame: CGRect(x: 68, y: 130 + yPos, width: 200, height: 150))
        
        //Design Attributes for all text
        labelHeader.text = title
        labelHeader.textColor = UIColor(hue: 211/360, saturation: 21/100, brightness: 53/100, alpha: 1.0)
        labelHeader.font = UIFont(name: "Helvetica Bold", size: 30)
        labelContent.text = content
        labelContent.textColor = UIColor(hue: 211/360, saturation: 21/100, brightness: 53/100, alpha: 1.0)
        labelContent.font = UIFont(name: "Helvetica", size: 15)
        labelContent.numberOfLines = 8
        labelContent.sizeToFit()
        labelContent.lineBreakMode = .byWordWrapping
        
        //assign background image that will be the "flier" for each event. Users "Rectangle 1"
        container.backgroundColor = UIColor(patternImage: image!)
        
        //resizing the header to fit properly
        if(title.count > 13){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 25)
        }
        if(title.count > 16){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 20)
        }
        if(title.count > 19){
            labelHeader.font = UIFont(name: "Helvetica Bold", size: 18)
        }
        
        //adds all objects to the scroll view
        scroller.addSubview(container)
        scroller.addSubview(labelHeader)
        scroller.addSubview(labelContent)
        
        //Resize content size of UIScrollView
        //Reposition where next image would be
        yPos += 400
        self.scroller.contentSize = CGSize(width: 0,height: CGFloat(yPos + 100))
    }

}
