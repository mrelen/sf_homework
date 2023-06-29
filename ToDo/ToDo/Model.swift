//
//  Model.swift
//  ToDo
//
//  Created by OneClick on 29/6/23.
//

import Foundation

# Model
class ToDoItem:
    def __init__(self, title, completed=False):
        self.title = title
        self.completed = completed


class ToDoList:
    def __init__(self):
        self.items = []

    def add_item(self, title):
        item = ToDoItem(title)
        self.items.append(item)

    def remove_item(self, index):
        if index < len(self.items):
            del self.items[index]

    def mark_item_as_completed(self, index):
        if index < len(self.items):
            self.items[index].completed = True

