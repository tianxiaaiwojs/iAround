//
//  Common.swift
//  iAround
//
//  Created by ZhuBei on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import Foundation
import UIKit;

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
}
