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
        
        // Populate some initial todos
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
        let selectedToDo = todos[indexPath.row]
        
        // Perform any action when a todo is selected
        print("Selected todo: \(selectedToDo.title)")
    }
}


