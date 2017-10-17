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
