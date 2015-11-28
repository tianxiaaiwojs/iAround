//
//  UserInfo+CoreDataProperties.swift
//  iAround
//
//  Created by ZhuBei on 28/11/15.
//  Copyright © 2015 Team3. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserInfo {

    @NSManaged var loginName: String?
    @NSManaged var password: String?
    @NSManaged var userName: String?
    @NSManaged var userId: NSNumber?

}
