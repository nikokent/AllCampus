//
//  ViewController.swift
//  AllCampus
//
//  Created by Local Admin on 9/27/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        if(defaults.string(forKey: "testData") == nil){
            defaults.set("VCEA Career Expo~An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.~Oct 28, 2017 10:30 am~Oct 28, 2017 3:30 pm~0~1~710 SE Chinook Dr apt K51, 99163, Pullman WA~Kickback at our place~Bring your own drinks. We are grilling burgers and have music setup.~Oct 27, 2017 8:30 pm~Oct 27, 2017 11:30 pm~0~2~710 SE Chinook Dr apt K51, 99163, Pullman WA~Party At AKL!~Full on rager at AKL tonight. Girls bring your friends! It'll be lit! 🔥~Oct 30, 2017 11:00 pm~Oct 31, 2017 2:00 am~0~3~710 SE Chinook Dr apt K51, 99163, Pullman WA~Pullman Farmer's Market~Downtown Pullman will be having a Farmer's market! There will be plenty of stalls with Local Produce, Clothing, and More. There will be live music and plenty of fun for the whole family! See you there 🐮~Nov 5, 2017 8:00 am~Nov 5, 2017 2:00 pm~0~4~710 SE Chinook Dr apt K51, 99163, Pullman WA~", forKey: "testData")
        }
        
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getRoseGradient()
        gradientLayer.frame = self.view.frame
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        var builder = EventBuilder()
        builder.getEvents()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
