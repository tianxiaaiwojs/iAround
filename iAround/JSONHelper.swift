//
//  JSONHelper.swift
//  iAround
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.

//JSON Format:
//{"entityName": "UserEntity",
//  "detail" : {
//              "PersonId" : "1",
//              "privateId" : "tianxiaaiwojs@gmail.com",
//              "Password" : "(Encrypt Password)
//              "Name" : "Zhu Bei Bei"
//              "Gender" : "M" //here should use enum.
//              "ContactNo" : "88887777"
//              }
//}
//

import Foundation

class JSONHelper{
    static let Instance : JSONHelper = JSONHelper();
    
    private init(){};
    
    
    
    
    func getEntityJson(data : NSData) -> Dictionary<String, AnyObject>?{
        do{
            let jsonOptional = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! Dictionary<String, AnyObject>
            
            return jsonOptional;
        }
        catch{
            
        }
        return nil;
    }
    
    func parseJSONToDictionary(data : NSData) ->NSDictionary?{
        do{
            let jsonOptional : NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            return jsonOptional;
        }
        catch{
            
        }
        return nil;
    }
}
