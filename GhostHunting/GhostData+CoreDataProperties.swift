//
//  GhostData+CoreDataProperties.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 25/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//
//

import Foundation
import CoreData


extension GhostData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GhostData> {
        return NSFetchRequest<GhostData>(entityName: "GhostData")
    }

    @NSManaged public var countCaught: Int16
    @NSManaged public var imageFileName: String?
    @NSManaged public var lifePercent: Double
    @NSManaged public var name: String?
    @NSManaged public var skullsClass: String?

}
