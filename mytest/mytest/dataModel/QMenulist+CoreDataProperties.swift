//
//  QMenulist+CoreDataProperties.swift
//  mytest
//
//  Created by knuproimac on 2020-07-18.
//  Copyright © 2020 tony. All rights reserved.
//
//

import Foundation
import CoreData


extension QMenulist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QMenulist> {
        return NSFetchRequest<QMenulist>(entityName: "QMenulist")
    }

    @NSManaged public var itemName: String?
    @NSManaged public var groupID: Int64
    @NSManaged public var itemID: Int64
    @NSManaged public var isBeChosen: Bool
    @NSManaged public var icon: String?

}
