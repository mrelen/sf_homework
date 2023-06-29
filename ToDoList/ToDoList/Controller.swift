//
//  ViewController.swift
//  ToDoList
//
//  Created by OneClick on 29/6/23.
//

import UIKit

class ToDoListViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    var todos: [ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        todos = [
            ToDo(title: "Купить продукты", completed: false),
            ToDo(title: "Написать MVC проект", completed: true),
            ToDo(title: "Выгулять собаку", completed: false)
        ]
    }
}

// MARK: - UITableViewDataSource

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var selectedToDo = todos[indexPath.row]
        selectedToDo.completed.toggle() // Toggle the completion status
        
        todos[indexPath.row] = selectedToDo // Update the todo in the array
        
        tableView.reloadRows(at: [indexPath], with: .automatic) // Reload the selected row
        
        // Perform any additional action when a todo is selected
        print("Selected todo: \(selectedToDo.title)")
    }
}


