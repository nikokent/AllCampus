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
        let defaults = UserDefaults.standard
        
        var uncompiled_data = defaults.string(forKey: "testData")!
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
        let defaults = UserDefaults.standard
        var uncompiled_data = defaults.string(forKey: "testData")!
        
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
    
    //Turn event into parsable data for http protocol
    func EventToString(event: postedEventData) -> String{
        var result: String = event.title + "~"
        result += event.content + "~"
        result += event.eventTime + "~"
        result += event.endTime + "~"
        result += "0" + "~"
        result += String(event.EventType) + "~"
        result += event.location + "~"
        return result
    }
    
}


