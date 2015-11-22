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
    var primaryId : String
    var password : String
    var name : String
    var gender : String
    var contactNo : String
    
    static private var personIdColumnName = "PersonId"
    static private var primaryIdColumnName = "PrimaryId"
    static private var passwordColumnName = "Password"
    static private var nameColumnName = "Name"
    static private var genderColumnName = "Gender"
    static private var contactNoColumnName = "ContactNo"
    
    init(personId : Int, primaryId : String, password : String, name : String, gender : String, contactNo : String){
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
                if let tmpPersonId = json[self.personIdColumnName] as AnyObject? as? Int { // Currently in beta 5 there is a bug that forces us to cast to AnyObject? first
                    if let tmpPrimary = json[self.primaryIdColumnName] as AnyObject? as? String {
                        if let tmpPassword = json[self.passwordColumnName] as AnyObject? as? String {
                            if let tmpName = json[self.nameColumnName] as AnyObject? as? String{
                                if let tmpGender = json[self.genderColumnName] as AnyObject? as? String{
                                    if let tmpContactNo = json[self.contactNoColumnName] as AnyObject? as? String{
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
    
    
    static func parseEntityToJson(entity : Entity) -> NSString{
        
        let userEntity = entity as! UserEntity
        
        let jsonCompatibleArray = [
            self.personIdColumnName : userEntity.contactNo,
            self.primaryIdColumnName : userEntity.primaryId,
            self.passwordColumnName : userEntity.password,
            self.nameColumnName : userEntity.name,
            self.genderColumnName : userEntity.gender,
            self.contactNoColumnName : userEntity.contactNo
            ]
        do{
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(jsonCompatibleArray, options: NSJSONWritingOptions.PrettyPrinted)
            var jsonText = NSString(data: jsonData,encoding: NSUTF8StringEncoding)
            
            //let jsonSummary = self.addHeadJson("UserEntity", jsonText : <#T##NSString#>)
            return jsonText!;
        }catch{
            
        }
        return "";
    }
    
    func getObjectName() -> NSString{
        return NSString(string: "UserEntity" as String);
    }
}
