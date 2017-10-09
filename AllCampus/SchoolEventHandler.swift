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
    init(title: String, content: String, eventTime: String, endTime: String, tagData: Int, EventType: Int){
        self.title = title
        self.content = content
        self.eventTime = eventTime
        self.endTime = endTime
        self.tagData = tagData
        self.EventType = EventType
    }
};


