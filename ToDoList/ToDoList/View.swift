//
//  View.swift
//  ToDoList
//
//  Created by OneClick on 29/6/23.
//

import Foundation


import UIKit

class ToDoTableViewCell: UITableViewCell {
  
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with todo: ToDo) {
        titleLabel.text = todo.title
        
        // условие, если задача выполнена
        if todo.completed {
            titleLabel.textColor = .gray
        } else {
            titleLabel.textColor = .blue
        }
    }
}
