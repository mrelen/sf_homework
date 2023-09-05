//
//  Model.swift
//  ToDoList
//
//  Created by OneClick on 29/6/23.
//

import Foundation
import CoreData

@objc(ToDoItem)
class ToDoItem: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var completed: Bool
}






