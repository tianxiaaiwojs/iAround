//
//  EventEntity.swift
//  iAround
//
//  Created by ZhuBei on 25/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

class EventEntity{
    var eventId : Int
    var holderId : Int
    var holderDate : NSDate
    var geoCode : NSString
    var type : NSString
    var numberOfJoin : Int
    var decription : NSString
    
    init(eventId : Int, holderId : Int, holderDate : NSDate, geoCode : NSString, type : NSString, numberOfJoin : Int, decription : NSString){
        self.eventId = eventId;
        self.holderId = holderId;
        self.holderDate = holderDate;
        self.geoCode = geoCode;
        self.type = type;
        self.numberOfJoin = numberOfJoin;
        self.decription = decription;
    }
}
