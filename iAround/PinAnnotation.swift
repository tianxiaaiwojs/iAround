//
//  PinAnnotation.swift
//  iAround
//
//  Created by ZhuBei on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//

import MapKit
import Foundation
import UIKit

class PinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var type : String = ""
    var title : String? = ""
    var subtitle : String? = ""
<<<<<<< HEAD
    var event : EventEntity? = nil
=======
    var event : EventEntity? = nil;
>>>>>>> origin/master
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
}
