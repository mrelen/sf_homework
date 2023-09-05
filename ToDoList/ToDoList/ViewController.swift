//
//  ViewController.swift
//  ToDoList
//
//  Created by OneClick on 29/6/23.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDragDelegate, UITableViewDropDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func Add(_ sender: Any) {
    }
    
    @IBAction func Trash(_ sender: Any) {
    }
    
    var todos: [ToDo] = []
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
          view.backgroundColor = .white

        
        tableView.delegate = self
        tableView.dataSource = self
        
        todos = [
            ToDo(title: "Купить продукты", completed: false),
            ToDo(title: "Написать MVC проект", completed: true),
            ToDo(title: "Выгулять собаку", completed: false)
        ]
        
        setupNavigationBar()
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        navigationItem.leftBarButtonItem = deleteButton
    }
    
    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Введите название задачи"
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let taskTitle = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !taskTitle.isEmpty,
                  let managedContext = self?.managedContext else {
                return
            }
            
            let newToDoItem = ToDoItem(context: managedContext)
            newToDoItem.title = taskTitle
            newToDoItem.completed = false
            
            do {
                try managedContext.save()
                self?.fetchToDos() // Refresh the todos array after saving
                self?.tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true) {
            alertController.textFields?.first?.becomeFirstResponder()
        }
    }

    
    @objc private func deleteButtonTapped() {
        if todos.isEmpty {
            let emptyListAlert = UIAlertController(
                title: "Список задач пуст",
                message: "Вы хотите добавить задачу?",
                preferredStyle: .alert
            )
            
            let addAction = UIAlertAction(title: "Добавить задачу", style: .default) { [weak self] _ in
                self?.addButtonTapped()
            }
            
            let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
            
            emptyListAlert.addAction(addAction)
            emptyListAlert.addAction(cancelAction)
            
            present(emptyListAlert, animated: true, completion: nil)
        } else {
            let confirmationAlert = UIAlertController(
                title: "Удалить все задачи",
                message: "Вы уверены, что хотите удалить все задачи?",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
            
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
                self?.todos.removeAll()
                self?.tableView.reloadData()
                
                if self?.todos.isEmpty ?? false {
                    self?.addButtonTapped()
                }
            }
            
            confirmationAlert.addAction(cancelAction)
            confirmationAlert.addAction(deleteAction)
            
            present(confirmationAlert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let todo = todos[indexPath.row]
        let itemProvider = NSItemProvider(object: todo.title as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = todo
        return [dragItem]
    }

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if tableView.hasActiveDrag {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }

        if coordinator.session.localDragSession != nil {
            // Local drag inside the app
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath)
        } else {
            // External drop from another app
            insertItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath)
        }
    }

    private func reorderItems(coordinator: UITableViewDropCoordinator, destinationIndexPath: IndexPath) {
        guard let items = coordinator.items.first,
              let sourceIndexPath = items.sourceIndexPath else {
            return
        }

        tableView.performBatchUpdates {
            let todo = todos[sourceIndexPath.row]
            todos.remove(at: sourceIndexPath.row)
            todos.insert(todo, at: destinationIndexPath.row)

            tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        }
    }

    private func insertItems(coordinator: UITableViewDropCoordinator, destinationIndexPath: IndexPath) {
        coordinator.session.loadObjects(ofClass: NSString.self) { [weak self] items in
            guard let titles = items as? [String] else {
                return
            }

            var indexPaths: [IndexPath] = []
            for (index, title) in titles.enumerated() {
                let todo = ToDo(title: title, completed: false)
                self?.todos.insert(todo, at: destinationIndexPath.row + index)
                indexPaths.append(IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section))
            }

            self?.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }


    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .destructive, title: "Edit") { [weak self] (_, _, completionHandler) in
            self?.showEditAlert(for: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .orange
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [editAction])
        return swipeConfig
    }
       
       private func showEditAlert(for indexPath: IndexPath) {
           let todo = todos[indexPath.row]
           let alertController = UIAlertController(title: "Редактировать", message: nil, preferredStyle: .alert)
           
           alertController.addTextField { textField in
               textField.placeholder = "Enter task title"
               textField.text = todo.title
           }
           
           let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self, weak alertController] _ in
               guard let textField = alertController?.textFields?.first,
                     let taskTitle = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                     !taskTitle.isEmpty else {
                   return
               }
               
               var updatedToDo = self?.todos[indexPath.row]
               updatedToDo?.title = taskTitle
               self?.todos[indexPath.row] = updatedToDo ?? todo
               self?.tableView.reloadData()
           }
           
           let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
           
           alertController.addAction(saveAction)
           alertController.addAction(cancelAction)
           
           present(alertController, animated: true) {
               alertController.textFields?.first?.becomeFirstResponder()
           }
       }
   }

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        cell.backgroundColor = .white
        
        return cell
    }
}

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var selectedToDo = todos[indexPath.row]
        selectedToDo.completed.toggle()
        todos[indexPath.row] = selectedToDo
        
        let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell
        cell?.configure(with: selectedToDo)
        tableView.reloadRows(at: [indexPath], with: .automatic) // перезагрузить строку
        
        print("Выбранные задачи: \(selectedToDo.title)") // выводит действия в консоль
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
