//
//  SchoolEventHandler.swift
//  AllCampus
//
//  Created by Local Admin on 10/4/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import Foundation

/*Struct to store the various text data needed for each event posting
 Contains:
 -Title of event
 -Description content
 -Time of event
 -tag data (This will be a single int passed in to each button to keep track of with event is which)
 -hasBeenAdded (boolean) for wether or not an event was added to User Calendar
 -EventType (1 = School Event, 2 = Parties, 3 = Greek Life, 4 = Misc)
 */
struct postedEventData {
    let title,content,endTime,eventTime: String
    var tagData: Int
    var hasBeenAdded = false
    let EventType: Int
    let location: String
    init(title: String, content: String, eventTime: String, endTime: String, tagData: Int, EventType: Int, location: String){
        self.title = title
        self.content = content
        self.eventTime = eventTime
        self.endTime = endTime
        self.tagData = tagData
        self.EventType = EventType
        self.location = location
    }
};

class EventBuilder{
    
    func getEvents() -> Array<postedEventData>{
        var uncompiled_data: String = "VCEA Career Expo~An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.~Oct 28, 2017 10:30 am~Oct 28, 2017 3:30 pm~0~1~710 SE Chinook Dr apt K51, 99163, Pullman WA~VCEA1 Career Expo~An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.~Oct 28, 2017 10:30 am~Oct 28, 2017 3:30 pm~0~1~710 SE Chinook Dr apt K51, 99163, Pullman WA~VCEA2 Career Expo~An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.~Oct 28, 2017 10:30 am~Oct 28, 2017 3:30 pm~0~1~710 SE Chinook Dr apt K51, 99163, Pullman WA~"
        var data_array = uncompiled_data.split(separator: "~")
        print("\(data_array.count/7) total event(s)")
        
        var eventData = [postedEventData]()
        var i = 0
        for _ in 1...(data_array.count/7)
        {
            var eventType: String = String(data_array[(5 + (i*7))])
            
            eventData.append(postedEventData(title: String(data_array[(0 + (i*7))]), content: String(data_array[(1 + (i*7))]), eventTime: String(data_array[(2 + (i*7))]), endTime: String(data_array[(3 + (i*7))]), tagData: 0, EventType: Int(eventType)!, location: String(data_array[(6 + (i*7))])))
            i += 1
        }
        return eventData
    }
    
    func testEvents() -> Array<postedEventData>{
        var uncompiled_data: String = "VCEA Career Expo~An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.~Oct 28, 2017 10:30 am~Oct 28, 2017 3:30 pm~0~1~710 SE Chinook Dr apt K51, 99163, Pullman WA~Kickback at our place~Bring your own drinks. We are grilling burgers and have music setup.~Oct 27, 2017 8:30 pm~Oct 27, 2017 11:30 pm~0~2~710 SE Chinook Dr apt K51, 99163, Pullman WA~Party At AKL!~Full on rager at AKL tonight. Girls bring your friends! It'll be lit! 🔥~Oct 30, 2017 11:00 pm~Oct 31, 2017 2:00 am~0~3~710 SE Chinook Dr apt K51, 99163, Pullman WA~Pullman Farmer's Market~Downtown Pullman will be having a Farmer's market! There will be plenty of stalls with Local Produce, Clothing, and More. There will be live music and plenty of fun for the whole family! See you there 🐮~Nov 5, 2017 8:00 am~Nov 5, 2017 2:00 pm~0~4~710 SE Chinook Dr apt K51, 99163, Pullman WA"
        var data_array = uncompiled_data.split(separator: "~")
        print("\(data_array.count/7) total event(s)")
        
        var eventData = [postedEventData]()
        var i = 0
        for _ in 1...(data_array.count/7)
        {
            var eventType: String = String(data_array[(5 + (i*7))])
            
            eventData.append(postedEventData(title: String(data_array[(0 + (i*7))]), content: String(data_array[(1 + (i*7))]), eventTime: String(data_array[(2 + (i*7))]), endTime: String(data_array[(3 + (i*7))]), tagData: 0, EventType: Int(eventType)!, location: String(data_array[(6 + (i*7))])))
            i += 1
        }
        return eventData
    }
    /*
        eventData.append(postedEventData(title:"VCEA Career Expo", content: "An awesome oppurtunity to network and share resumes with industry representatives that can give you an internship.",eventTime: "Oct 28, 2017 10:30 am",endTime: "Oct 28, 2017 3:30 pm" , tagData: 0, EventType: 1, location: "710 SE Chinook Dr apt K51, 99163, Pullman WA"))
    eventData.append(postedEventData(title:"Kickback at our place", content: "Bring your own drinks. We are grilling burgers and have music setup.",eventTime: "Oct 27, 2017 8:30 pm",endTime: "Oct 27, 2017 11:30 pm" , tagData: 0, EventType: 2, location: "710 SE Chinook Dr apt K51, 99163, Pullman WA"))
    eventData.append(postedEventData(title:"Party At AKL!", content: "Full on rager at AKL tonight. Girls bring your friends! It'll be lit! 🔥", eventTime: "Oct 30, 2017 11:00 pm", endTime: "Oct 31, 2017 2:00 am" , tagData: 0, EventType: 3, location: "710 SE Chinook Dr apt K51, 99163, Pullman WA"))
    eventData.append(postedEventData(title:"Pullman Farmer's Market", content: "Downtown Pullman will be having a Farmer's market! There will be plenty of stalls with Local Produce, Clothing, and More. There will be live music and plenty of fun for the whole family! See you there 🐮", eventTime: "Nov 5, 2017 8:00 am", endTime: "Nov 5, 2017 2:00 pm" , tagData: 0, EventType: 4, location: "710 SE Chinook Dr apt K51, 99163, Pullman WA"))
    */
    
}


