//
//  Service.swift
//  iAround

//this is proxy class.
//
//  Created by ZhuBei on 21/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation

public class Service{
    static let Instance : Service = Service();
    private let rootUrl : NSString = NSString(string : "http://52.32.120.191:8000/IEvent/EventsManager/reset/");
    private init(){}
    
    public func loginUrl() -> NSURL{
        return NSURL(string : ((rootUrl as String) + "Login"))!;
    }
    
    public func retriveEventsUrl() -> NSURL{
        return NSURL(string : ((rootUrl as String) + "RetriveEvents/{0}/{1}/{2}"))!
    }
}
