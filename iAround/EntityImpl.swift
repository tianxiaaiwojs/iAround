//
//  EntityImpl.swift
//  iAround
//
//  Created by ZhuBei on 23/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

class EntityImpl
{
    static func addHeadJson(entityName : NSString, json : NSString) ->NSString
    {
        return NSString(string : "{\"entityName:\""+(entityName as String)+",detail:"+(json as String)+"}");
    }
}
