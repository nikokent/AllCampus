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
    @IBOutlet weak var DateSelect: UIDatePicker!
    @IBOutlet weak var EndDetailsLabel: UILabel!
    @IBOutlet weak var EndContinueBTN: UIButton!
    @IBOutlet weak var EndTextView: UITextView!
    
    var xOffsetButtons: CGFloat = -0.3
    var eventStage = 0 //keep track of what stage of information is being added
    var restart = false
    var eventTitle: String = ""
    var eventContent: String = ""
    var eventLocation: String = ""
    var eventType: Int = 0
    var eventStartTime: String = ""
    var eventEndTime: String = ""
    override func viewDidLoad() {
        
        TitleField.text = eventTitle
       
        var tempDate = Date()
        DateSelect.minimumDate = Date()
        DateSelect.maximumDate = tempDate.addMonth(n: 12)
        TitleField.backgroundColor = UIColor.clear
        hideAll()
        
        EndDetailsLabel.isHidden = true
        EndContinueBTN.isHidden = true
        EndTextView.isHidden = true
        EndTextView.layer.cornerRadius = 15
        
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
        
        SchoolBtn.contentHorizontalAlignment = .left
        PartyBtn.contentHorizontalAlignment = .left
        GreekBtn.contentHorizontalAlignment = .left
        MiscBtn.contentHorizontalAlignment = .left
        
        SchoolBtn.frame.origin.x = xOffsetButtons
        PartyBtn.frame.origin.x = xOffsetButtons
        GreekBtn.frame.origin.x = xOffsetButtons
        MiscBtn.frame.origin.x = xOffsetButtons
        DescriptionField.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //handles removing the keyboard from view on "return" key press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        ContinueBtn.isHidden = false
        return false
    }
    //allows continute button to be viewed after text is input
    func textViewDidBeginEditing(_ textView: UITextView) {
        ContinueBtn.isHidden = false
    }
    
    //allows keyboard to be removed on return key pressed
    //also keyboard will disappear on textview drag
    func textViewDidChange(_ textView: UITextView) {
        if(DescriptionField.text.characters.last == "\n"){
            self.view.endEditing(true)
        }
    }
    
    
    //animates moving buttons out of view
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
    
    //**********************************Event Selection*****************************************
    //if school is initally selected
    //event type will be set accordingly and buttons will be moved out of view
    @IBAction func SchoolSelect(_ sender: Any) {
        eventType = 1
        moveButtons()
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's Plan a School Event!"
        }, completion: nil)
        if(TitleField.text != "")
        {
            ContinueBtn .isHidden = false
        }
    }
    @IBAction func PartySelect(_ sender: Any) {
        eventType = 2
        moveButtons()
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's\nThrow\na Party."
        }, completion: nil)
        if(TitleField.text != "")
        {
            ContinueBtn.isHidden = false
        }
    }
    @IBAction func GreekSelect(_ sender: Any) {
        eventType = 3
        moveButtons()
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's Plan\na Greek Event!"
        }, completion: nil)
        if(TitleField.text != "")
        {
            ContinueBtn.isHidden = false
        }
    }
    @IBAction func MiscSelect(_ sender: Any) {
        eventType = 4
        moveButtons()
        
        UIView.animate(withDuration: 2.5, animations: {
            self.HeaderLabel.text = "Let's Plan\nan Event!"
        }, completion: nil)
        if(TitleField.text != "")
        {
            ContinueBtn.isHidden = false
        }
    }
    //**********************************End Event Selection*****************************************
    
    //Handles if restart button is selected
    //  user will return to first screen however all fields are still
    //  populated with necessary information.
    @IBAction func RestartSelect(_ sender: Any) {
        restart = false
        TitleField.text = ""
            eventStage = 0
            self.viewDidLoad()
            self.viewWillAppear(true)
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
        DateSelect.isHidden = true
    }
    
    //Moves the user along based off of which "stage" in the event planning process they are on
    //  First:  Type of Event
    //  Second: Title of event
    //  Third:  Description of event
    //  Fourth: Location of event
    //  Fifth:  Start time of event
    //  Sixth:  End Time of event
    //  Seventh:Review All Details
    @IBAction func ContinueSelect(_ sender: Any) {
        if(TitleField.text != "" || eventStage >= 1){
            eventStage += 1
            self.view.endEditing(true)
            
            if(eventStage == 1)
            {
                    eventTitle = TitleField.text!
                    TitleField.text = eventTitle
                    TitleLabel.text = "Perfect, Now lets write a good description of your event 🎉"
                    DescriptionField.text = eventContent
                    DescriptionField.isHidden = false
                    TitleField.isHidden = true
                
            }
            if(eventStage == 2)
            {
                eventContent = DescriptionField.text
                TitleLabel.text = "Nice, Now lets tell everyone where to meet! 🏠"
                DescriptionField.isHidden = true
                TitleField.isHidden = false
                TitleField.placeholder = "1234 NE D ST, 99164, Pullman, WA"
                TitleField.text = eventLocation
                DateSelect.isHidden = true
            }
            if(eventStage == 3){
                eventLocation = TitleField.text!
                TitleField.isHidden = true
                TitleLabel.text = "Almost done! We just need to pick the Starting Time and Date 🕣"
                DateSelect.isHidden = false
            }
            if(eventStage == 4){
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy h:mm a"
                eventStartTime = formatter.string(from: DateSelect.date)
                print(formatter.string(from: DateSelect.date))
                DateSelect.date.addDay(n: 1)
                TitleField.isHidden = true
                TitleLabel.text = "Lastly, We just need to pick the End Time and Date 🕤"
            }
            if(eventStage == 5){
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy h:mm a"
                eventEndTime = formatter.string(from: DateSelect.date)
                print(formatter.string(from: DateSelect.date))
                TitleField.isHidden = true
                DateSelect.isHidden = true
                TitleLabel.isHidden = true
                ContinueBtn.isHidden = true
                HeaderLabel.text = "Great! Now just check that these details are right"
                EndContinueBTN.isHidden = false
                EndTextView.isHidden = false
                EndTextView.text = "Title: \(eventTitle)\n\n\nDescription: \(eventContent)\n\n\nLocation: \(eventLocation)\n\n\nTime: \n\(eventStartTime) to \(eventEndTime)"
            }
            if(eventStage == 6){
                let defaults = UserDefaults.standard
                EndContinueBTN.isHidden = true
                EndTextView.isHidden = true
                HeaderLabel.text = "Your event should be available for everyone to see soon 😇"
                var finalData = "\(eventTitle)~\(eventContent)~\(eventStartTime)~\(eventEndTime)~0~\(eventType)~\(eventLocation)~"
                finalData += defaults.string(forKey: "testData")!
                defaults.set(finalData,forKey: "testData")
            }
        }
    }
    
}


//Stack Overflow - Soohwan Park
//stackoverflow.com/questions/8119880/how-to-add-one-month-to-an-nsdate
//extension to add time to a date object
extension Date {
    func addMonth(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .month, value: n, to: self)!
    }
    func addDay(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: n, to: self)!
    }
    func addSec(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .second, value: n, to: self)!
    }
}
