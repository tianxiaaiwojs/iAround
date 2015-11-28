//
//  EventEntity.swift
//  iAround
//
//  Created by ZhuBei on 25/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

class EventEntity : EntityImpl, Entity{
    var eventId : Int
    var CreatedById : Int
    var createdBy : String
    var title : String
    var eventDate : NSDate
    var latitude : String
    var longitude : String
    var eventType : String
    var numberOfJoin : Int
    var eventDesc : String
    var address : String
    
    
    static private var eventIdColumnName = "EventID"
    static private var createdByIdColumnName = "CreatedByID"
    static private var createdByColumnName = "CreatedBy"
    static private var titleColumnName = "EventTitle"
    static private var eventDateColumnName = "EventDate"
    static private var latitudeColumnName = "Latitude"
    static private var longitudeColumnName = "Longitude"
    static private var eventTypeColumnName = "EventType"
    static private var numberOfJoinColumnName = "NumOfPerson"
    static private var eventDescColumnName = "EventDesc"
    static private var addressColumnName = "Address"
    
    
    
    init(eventId : Int, createdById : Int, createdBy : String, title : String, eventDate : NSDate, latitude : String, longitude : String, eventType : String, numberOfJoin : Int, eventDesc : String, address : String){
        self.eventId = eventId;
        self.CreatedById = createdById;
        self.createdBy = createdBy
        self.title = title;
        self.eventDate = eventDate;
        self.latitude = latitude;
        self.longitude = longitude;
        self.eventType = eventType;
        self.numberOfJoin = numberOfJoin;
        self.eventDesc = eventDesc;
        self.address = address;
    }
    
    static func parseJsonToEntity(data : Dictionary<String, AnyObject>) ->Entity?{
        if let eventId = data[EventEntity.eventIdColumnName] as AnyObject? as? Int{
            if let createbyId = data[EventEntity.createdByIdColumnName] as AnyObject? as? Int{
                if let createby = data[EventEntity.createdByColumnName] as AnyObject? as? String{
                    if let title = data[EventEntity.titleColumnName] as AnyObject? as? String{
                        if let eventDate = data[EventEntity.eventDateColumnName] as AnyObject? as? String{
                            if let latitude = data[EventEntity.latitudeColumnName] as AnyObject? as? String{
                                if let longitude = data[EventEntity.longitudeColumnName] as AnyObject? as? String{
                                    if let eventType = data[EventEntity.eventTypeColumnName] as AnyObject? as? String{
                                        if let numberofJoin = data[EventEntity.numberOfJoinColumnName] as AnyObject? as? Int{
                                            if let eventDesc = data[EventEntity.eventDescColumnName] as AnyObject? as? String{
                                                if let address = data[EventEntity.addressColumnName] as AnyObject? as? String{
                                                    return EventEntity(eventId: eventId, createdById: createbyId, createdBy: createby, title: title, eventDate: Common.parseStringToDate(eventDate), latitude: latitude, longitude: longitude, eventType: eventType, numberOfJoin: numberofJoin, eventDesc: eventDesc, address: address)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return nil;
    }
    
    func parseEntityToJson() -> NSString{
        let eventEntity = self;
        
        let jsonCompatibleArray = [
            EventEntity.eventIdColumnName : eventEntity.eventId,
            EventEntity.createdByIdColumnName : eventEntity.CreatedById,
            EventEntity.createdByColumnName : eventEntity.createdBy,
            EventEntity.titleColumnName : eventEntity.title,
            EventEntity.eventDateColumnName : eventEntity.eventDate,
            EventEntity.latitudeColumnName : eventEntity.latitude,
            EventEntity.longitudeColumnName : eventEntity.longitude,
            EventEntity.eventTypeColumnName : eventEntity.eventType,
            EventEntity.numberOfJoinColumnName : eventEntity.numberOfJoin,
            EventEntity.eventDescColumnName : eventEntity.eventDesc,
            EventEntity.addressColumnName : eventEntity.address
        ]
        do{
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(jsonCompatibleArray, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonText = NSString(data: jsonData,encoding: NSUTF8StringEncoding)
            
            let jsonSummary = UserEntity.addHeadJson("EventEntity", json : jsonText!)
            return jsonSummary;
        }catch{
            
        }
        return "";
    
    }
    
    func getObjectName() -> NSString{
        return NSString(string: "EventEntity" as String);
    }
    
    
}
