//
//  ViewController.swift
//  ToDoList
//
//  Created by OneClick on 29/6/23.
//

import UIKit

class ToDoListViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func Add(_ sender: Any) {
    }
    
    @IBAction func Trash(_ sender: Any) {
    }
    
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
           
           setupNavigationBar()
       }
       
       private func setupNavigationBar() {
         // +
           let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
           navigationItem.rightBarButtonItem = addButton
           
        // корзина
           let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
           navigationItem.leftBarButtonItem = deleteButton
       }
     
    // нажатие кнопки +
    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Введите название задачи"
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let taskTitle = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !taskTitle.isEmpty else {
                return
            }
            
            let newTask = ToDo(title: taskTitle, completed: false)
            self?.todos.append(newTask)
            
            // Обновить вью таблицы
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true) {
            alertController.textFields?.first?.becomeFirstResponder()
        }
    }



     // корзина нажатие (удалить одну задачу можно при свайпе влево)
    @objc private func deleteButtonTapped() {
        
        // показать уведомление о подтверждении
        let confirmationAlert = UIAlertController(
            title: "Удалить все задачи",
            message: "Вы уверены, что хотите удалить все задачи?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            // удалить все задачи
            self?.todos.removeAll()

            // обновить вью
            self?.tableView.reloadData()

            // вывести окно "добавить задачу"
            if self?.todos.isEmpty ?? false {
                self?.addButtonTapped()
            }
        }
        
        confirmationAlert.addAction(cancelAction)
        confirmationAlert.addAction(deleteAction)
        
        present(confirmationAlert, animated: true, completion: nil)
    }
   }

   // MARK: - UITableViewDataSource

// возвращает количество массива todos, показывая количество задач в таблице
   extension ToDoListViewController: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return todos.count
       }
       
       // извлечение и настройка ячейки для указанного пути индекса строки
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
           
           let todo = todos[indexPath.row]
           cell.configure(with: todo)
           // возвращает настроенную ячейку для отображения в виде таблицы
           return cell
       }
   }

// MARK: - UITableViewDelegate

extension ToDoListViewController: UITableViewDelegate {
    //отменяет выбор выбранной строки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var selectedToDo = todos[indexPath.row]
        selectedToDo.completed.toggle() // переключает статус завершения задачи
        
        todos[indexPath.row] = selectedToDo // обновить задачу
        
        tableView.reloadRows(at: [indexPath], with: .automatic) // перезагрузить строку
        
        print("Выбранные задачи: \(selectedToDo.title)") // выводит действия в консоль
    }
    
    // редактирование строки (когда пользователь проводит пальцем, чтобы удалить ее)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      // проверяет, является ли стиль редактирования «.delete»
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


