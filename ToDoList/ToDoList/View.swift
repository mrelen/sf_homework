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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            toggleHighlight()
        }
    }
    
    private func toggleHighlight() {
        if titleLabel.textColor == .gray {
            contentView.backgroundColor = UIColor.clear
        } else {
            contentView.backgroundColor = contentView.backgroundColor == UIColor.secondarySystemFill ? UIColor.clear : UIColor.secondarySystemFill
        }
    }

    
    func configure(with todo: ToDo) {
        titleLabel.text = todo.title
        if todo.completed {
            titleLabel.textColor = .gray
            contentView.backgroundColor = UIColor.clear
        } else {
            titleLabel.textColor = .blue
            contentView.backgroundColor = UIColor.clear
        }
    }
}
