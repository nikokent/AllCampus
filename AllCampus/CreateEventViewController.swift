//
//  CreateEventViewController.swift
//  AllCampus
//
//  Created by Local Admin on 10/11/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var HeaderLabel: UILabel!
    @IBOutlet weak var SchoolBtn: UIButton!
    @IBOutlet weak var PartyBtn: UIButton!
    @IBOutlet weak var GreekBtn: UIButton!
    @IBOutlet weak var MiscBtn: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var ContinueBtn: UIButton!
    @IBOutlet weak var DescriptionField: UITextView!
    
    var xOffsetButtons: CGFloat = 0.0
    var eventStage = 0 //keep track of what stage of information is being added
    
    override func viewDidLoad() {
        TitleField.backgroundColor = UIColor.clear
        hideAll()
        
        self.TitleField.delegate = self
        self.DescriptionField.delegate = self
        super.viewDidLoad()
        //label styling
        HeaderLabel.text = "What kind of event should we put on?"
       // HeaderLabel.sizeToFit()
        if(xOffsetButtons == 0){
            xOffsetButtons = SchoolBtn.frame.origin.x
        }
        
        //view controller's background gradient
        var gradient = ColorsHandler()
        var gradientLayer: CAGradientLayer
        gradientLayer = gradient.getBoraBoraGradient()
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        //Button styling
        SchoolBtn.contentHorizontalAlignment = .right
        PartyBtn.contentHorizontalAlignment = .right
        GreekBtn.contentHorizontalAlignment = .right
        MiscBtn.contentHorizontalAlignment = .right
        SchoolBtn.frame.origin.x = xOffsetButtons
        PartyBtn.frame.origin.x = xOffsetButtons
        GreekBtn.frame.origin.x = xOffsetButtons
        MiscBtn.frame.origin.x = xOffsetButtons
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        ContinueBtn.isHidden = false
        return false
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        DescriptionField.text = ""
        ContinueBtn.isHidden = false
    }
    
    func moveButtons(){
        UIView.animate(withDuration: 1, animations: {
            self.SchoolBtn.frame.origin.x -=  -1000
        }, completion: nil)
        UIView.animate(withDuration: 1.5, animations: {
            self.PartyBtn.frame.origin.x -=  -1000
        }, completion: nil)
        UIView.animate(withDuration: 2, animations: {
            self.GreekBtn.frame.origin.x -=  -1000
        }, completion: nil)
        UIView.animate(withDuration: 2.5, animations: {
            self.MiscBtn.frame.origin.x -=  -1000
        }, completion: nil)
        titleEvent()
    }
    @IBAction func SchoolSelect(_ sender: Any) {
        moveButtons()
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's Plan This School Event!"
        }, completion: nil)
    }
    @IBAction func PartySelect(_ sender: Any) {
        moveButtons()
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's\nThrow\nA Party."
        }, completion: nil)
    }
    @IBAction func GreekSelect(_ sender: Any) {
        moveButtons()
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's Plan\nThis Greek Event!"
        }, completion: nil)
    }
    @IBAction func MiscSelect(_ sender: Any) {
        moveButtons()
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's Plan\nThis Community Event!"
        }, completion: nil)
        
    }
    @IBAction func RestartSelect(_ sender: Any) {
        self.viewDidLoad()
        self.viewWillAppear(true)
        TitleField.text = ""
        eventStage = 0
    }
    
    func titleEvent(){
        TitleField.isHidden = false
        TitleLabel.isHidden = false
    }
    func hideAll(){
        ContinueBtn.isHidden = true
        TitleField.isHidden = true
        TitleLabel.isHidden = true
        DescriptionField.isHidden = true
    }
    @IBAction func ContinueSelect(_ sender: Any) {
        eventStage += 1
        self.view.endEditing(true)
        TitleField.text = ""
        if(eventStage == 1)
        {
            TitleLabel.text = "Perfect, Now lets write a good description of your event 🎉"
            DescriptionField.isHidden = false
            TitleField.isHidden = true
        }
        if(eventStage == 2)
        {
            TitleLabel.text = "Nice, Now lets tell everyone where to meet!"
            DescriptionField.isHidden = true
            TitleField.isHidden = false
            TitleField.placeholder = "1234 NE D ST, 99164, Pullman, WA"
        }
    }
    
}
