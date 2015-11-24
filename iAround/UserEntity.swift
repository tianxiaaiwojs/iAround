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
    var primaryId : NSString
    var password : NSString
    var name : NSString
    var gender : NSString
    var contactNo : NSString
    
    static private var personIdColumnName = "PersonId"
    static private var primaryIdColumnName = "PrimaryId"
    static private var passwordColumnName = "Password"
    static private var nameColumnName = "Name"
    static private var genderColumnName = "Gender"
    static private var contactNoColumnName = "ContactNo"
    
    init(personId : Int, primaryId : NSString, password : NSString, name : NSString, gender : NSString, contactNo : NSString){
        self.personId = personId;
        self.primaryId = primaryId;
        self.password = password;
        self.name = name;
        self.gender = gender;
        self.contactNo = contactNo;
    }
    
    private override init(){
        self.personId = -1;
        self.primaryId = "";
        self.password = "";
        self.name = "";
        self.gender = "";
        self.contactNo = "";
    }
    
    init(primaryId : String, password : String){
        self.personId = -1;
        self.primaryId = primaryId;
        self.password = password;
        self.name = "";
        self.gender = "";
        self.contactNo = "";
    }
    
    static func parseJsonToEntity(data : NSData) ->Entity{
        
        do{
            let jsonOptional : AnyObject! = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            
            
            if let json = jsonOptional as? Dictionary<String, AnyObject>
            {
                if let tmpPersonId = json[UserEntity.personIdColumnName] as AnyObject? as? Int { // Currently in beta 5 there is a bug that forces us to cast to AnyObject? first
                    if let tmpPrimary = json[UserEntity.primaryIdColumnName] as AnyObject? as? String {
                        if let tmpPassword = json[UserEntity.passwordColumnName] as AnyObject? as? String {
                            if let tmpName = json[UserEntity.nameColumnName] as AnyObject? as? String{
                                if let tmpGender = json[UserEntity.genderColumnName] as AnyObject? as? String{
                                    if let tmpContactNo = json[UserEntity.contactNoColumnName] as AnyObject? as? String{
                                        return UserEntity( personId : tmpPersonId, primaryId : tmpPrimary,password : tmpPassword, name : tmpName, gender : tmpGender, contactNo : tmpContactNo);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }catch{
            
        }
        
        return UserEntity();

    }
    
    
    func parseEntityToJson() -> NSString{
        
        let userEntity = self;
        
        let jsonCompatibleArray = [
            UserEntity.personIdColumnName : userEntity.contactNo,
            UserEntity.primaryIdColumnName : userEntity.primaryId,
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
