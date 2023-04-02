//
//  MyViewController.swift
//  ExploringTableView
//
//  Created by OneClick on 21/3/23.
//

import UIKit

class MyViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register cell classes
        
        // Set up number of sections
        let numberOfSectionsSelector = #selector(numberOfSections(in:))
        if self.responds(to: numberOfSectionsSelector) {
            self.perform(numberOfSectionsSelector, with: tableView)
        }
        
        // Set up number of rows in each section
        let numberOfRowsInSectionSelector = #selector(tableView(_:numberOfRowsInSection:))
        if self.responds(to: numberOfRowsInSectionSelector) {
            self.perform(numberOfRowsInSectionSelector, with: tableView, with: 0)
        }
        
        // Set up cells
        let cellForRowAtSelector = #selector(tableView(_:cellForRowAt:))
        if self.responds(to: cellForRowAtSelector) {
            let indexPath = IndexPath(row: 0, section: 0)
            self.perform(cellForRowAtSelector, with: tableView, with: indexPath)
        }
        
        // Set up editing
        let canEditRowAtSelector = #selector(tableView(_:canEditRowAt:))
        if self.responds(to: canEditRowAtSelector) {
            self.perform(canEditRowAtSelector, with: tableView, with: IndexPath(row: 0, section: 0))
        }
        
        let commitEditingStyleSelector = #selector(tableView(_:commit:forRowAt:))
        if self.responds(to: commitEditingStyleSelector) {
            self.perform(commitEditingStyleSelector, with: tableView, with: UITableViewCell.EditingStyle.delete, with: IndexPath(row: 0, section: 0))
        }
        
        // Set up reordering
        let canMoveRowAtSelector = #selector(tableView(_:canMoveRowAt:))
        if self.responds(to: canMoveRowAtSelector) {
            self.perform(canMoveRowAtSelector, with: tableView, with: IndexPath(row: 0, section: 0))
        }
        
        let moveRowAtSelector = #selector(tableView(_:moveRowAt:to:))
        if self.responds(to: moveRowAtSelector) {
            self.perform(moveRowAtSelector, with: tableView, with: IndexPath(row: 0, section: 0), with: IndexPath(row: 0, section: 0))
        }
    }

    @objc func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }

    // Override to support conditional editing of the table view.
    @objc func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    @objc func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to
