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
 */
struct postedEventData {
    let title,content,eventTime: String
    init(title: String, content: String, eventTime: String){
        self.title = title
        self.content = content
        self.eventTime = eventTime
    }
    
    
};


