//
//  UserEntity.swift
//  iAround
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

class UserEntity : EntityImpl ,Entity{
    var personId : Int
    var password : String
    var name : String
    var gender : String
    var contactNo : String
    
    static private var personIdColumnName = "ID"
    static private var passwordColumnName = "Password"
    static private var nameColumnName = "Name"
    static private var genderColumnName = "Sex"
    static private var contactNoColumnName = "ContactNo"
    
    init(personId : Int, password : String, name : String, gender : String, contactNo : String){
        self.personId = personId;
        self.password = password;
        self.name = name;
        self.gender = gender;
        self.contactNo = contactNo;
    }
    
    private override init(){
        self.personId = -1;
        self.password = "";
        self.name = "";
        self.gender = "";
        self.contactNo = "";
    }
    
    init(primaryId : String, password : String){
        self.personId = -1;
        self.password = password;
        self.name = "";
        self.gender = "";
        self.contactNo = "";
    }
    
    static func parseJsonToEntity(json : Dictionary<String, AnyObject>) ->Entity?{
        
        
        if let tmpPersonId = json[UserEntity.personIdColumnName] as AnyObject? as? Int {
            if let tmpPassword = json[UserEntity.passwordColumnName] as AnyObject? as? String {
                if let tmpName = json[UserEntity.nameColumnName] as AnyObject? as? String{
                    if let tmpGender = json[UserEntity.genderColumnName] as AnyObject? as? String{
                        if let tmpContactNo = json[UserEntity.contactNoColumnName] as AnyObject? as? String{
                            return UserEntity( personId : tmpPersonId, password : tmpPassword, name : tmpName, gender : tmpGender, contactNo : tmpContactNo);
                        }
                    }
                }
            }
            
        }
        
        return nil

    }
    
    
    func parseEntityToJson() -> NSString{
        
        let userEntity = self;
        
        let jsonCompatibleArray = [
            UserEntity.personIdColumnName : userEntity.personId,
            UserEntity.passwordColumnName : userEntity.password,
            UserEntity.nameColumnName : userEntity.name,
            UserEntity.genderColumnName : userEntity.gender,
            UserEntity.contactNoColumnName : userEntity.contactNo
            ]
        do{
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(jsonCompatibleArray, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonText = NSString(data: jsonData,encoding: NSUTF8StringEncoding)
            
            let jsonSummary = UserEntity.addHeadJson("UserEntity", json : jsonText!)
            return jsonSummary;
        }catch{
            
        }
        return "";
    }
    
    func getObjectName() -> NSString{
        return NSString(string: "UserEntity" as String);
    }
}
