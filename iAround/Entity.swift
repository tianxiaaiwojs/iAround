//
//  Entity.swift
//  iAround
//
//  Created by ZhuBei on 23/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

protocol Entity{
    static func parseJsonToEntity(data : NSData) ->Entity;
    static func parseEntityToJson(entity : Entity) ->NSString;
    
    func getObjectName() ->NSString;
}
