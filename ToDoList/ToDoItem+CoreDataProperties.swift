//
//  ToDoItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by OneClick on 29/8/23.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var completed: Bool

}

extension ToDoItem : Identifiable {

}
