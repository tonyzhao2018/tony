//
//  QMenuGroup+CoreDataProperties.swift
//  mytest
//
//  Created by knuproimac on 2020-07-18.
//  Copyright © 2020 tony. All rights reserved.
//
//

import Foundation
import CoreData


extension QMenuGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QMenuGroup> {
        return NSFetchRequest<QMenuGroup>(entityName: "QMenuGroup")
    }

    @NSManaged public var groupID: Int64
    @NSManaged public var name: String?
    @NSManaged public var icon: String?

}
