//
//  EventEntity.swift
//  iAround
//
//  Created by ZhuBei on 25/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

class EventEntity : EntityImpl{
    var eventId : Int
    var holderId : Int
    var title : String
    var holderDate : NSDate
    var geoCode : String
    var type : String
    var numberOfJoin : Int
    var decription : String
    
    init(eventId : Int, holderId : Int, title : String, holderDate : NSDate, geoCode : String, type : String, numberOfJoin : Int, decription : String){
        self.eventId = eventId;
        self.holderId = holderId;
        self.title = title;
        self.holderDate = holderDate;
        self.geoCode = geoCode;
        self.type = type;
        self.numberOfJoin = numberOfJoin;
        self.decription = decription;
    }
}
