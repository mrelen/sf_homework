//
//  ViewController.swift
//  ProjectWithRealm
//
//  Created by OneClick on 1/9/23.
//

import UIKit
import RealmSwift
 
let identifierCell = "UsefulConnectionsCell"
 
class UsefulConnectionsTVC: UITableViewController {
 
 
  var usefulConnections: Results<UsefulConnectionModel>!
 
  @IBOutlet weak var emaiLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
 
  override func viewDidLoad() {
    super.viewDidLoad()
 
    let realm = RealmService.shared.rm
    usefulConnections = realm.objects(UsefulConnectionModel.self)
 
  print(Realm.Configuration.defaultConfiguration.fileURL)
 
  }
 
  @IBAction func addConnection(_ sender: Any) {
    AlertService.shared.addAlert(controller: self) {  [unowned self] email, description, rating in
      let newUsefulConnection = UsefulConnectionModel(email: email, description: description, rating: rating)
      RealmService.shared.create(newUsefulConnection)
      self.tableView.reloadData()
    }
  }
 
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
 
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usefulConnections.count
  }
 
 
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? UsefulConnectionCell else { return UITableViewCell() }
 
    cell.configureCell(with: usefulConnections[indexPath.row])
    return cell
  }
 
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let usefulConnection = usefulConnections[indexPath.row]
 
    AlertService.shared.updateAlert(controller: self, usefulModel: usefulConnection) { [unowned self] email, description, rating in
      let dict: [String: Any] = ["emailLabel": email,
                                 "descriptionLabel": description,
                                 "ratingLabel": rating]
 
      RealmService.shared.update(usefulConnection, dictionary: dict)
      self.tableView.reloadData()
    }
  }
 
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
 
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let usefulConnection = usefulConnections[indexPath.row]
      RealmService.shared.delete(usefulConnection)
 
      tableView.deleteRows(at: [indexPath], with: .automatic)
      self.tableView.reloadData()
 
    }
  }
 
 
}



