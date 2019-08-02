//
//  Task+CoreDataProperties.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 30/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var descricao: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var number: Int16
    

}
