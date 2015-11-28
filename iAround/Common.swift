//
//  Common.swift
//  iAround
//
//  Created by ZhuBei on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation
import UIKit;
import CoreData;

class Common{
    static func getImage(type : String) -> UIImage{
        
        switch(type){
        case EventType.Sports.rawValue:
            return UIImage(named : "sports.png")!;
        case EventType.Travel.rawValue:
            return UIImage(named: "travel.png")!;
        case EventType.Party.rawValue:
            return UIImage(named: "party.png")!;
        default:
            return UIImage(named: "community.png")!;
        }
        
    }
    
    static func getUserInfo() -> UserInfo?{
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let userInfo = NSEntityDescription.entityForName("UserInfo", inManagedObjectContext: managedObjectContext)
        let request = NSFetchRequest();
        request.entity = userInfo;
        
        do{
            let result = try managedObjectContext.executeFetchRequest(request);
            if(result.count>0){
                return result[0] as? UserInfo
            }
        }catch{
            //Do Nothing,
        }
        return nil;
    }
    
    static func setUserInfo(user : UserInfo){
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        var userInfoObject = getUserInfo();
        do{
            try managedObjectContext.save()
        }catch{
            //Donothing
        }
    }
    
    static func parseStringToDate(string : String) ->NSDate{
        return parseStringToDate(string, dateFormat: "yyyy-MM-dd hh:mm")
    }
    
    static func parseStringToDate(string : String, dateFormat : String) ->NSDate
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat;
        let date = dateFormatter.dateFromString(string);
        return date!;
    }
    
    static func parseStringToDate(string : String, dateFormatter : NSDateFormatter) ->NSDate
    {
        let date = dateFormatter.dateFromString(string);
        return date!;
    }
}
