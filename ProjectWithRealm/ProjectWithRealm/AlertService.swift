//
//  AlertService.swift
//  ProjectWithRealm
//
//  Created by OneClick on 1/9/23.
//

import Foundation
import UIKit
 
class AlertService {
  private init (){}
 
  static let shared = AlertService()
 
  func addAlert(controller: UIViewController, completion: @escaping (String, String, Int)->()){
    let alert = UIAlertController(title: "Add new connection", message: "", preferredStyle: .alert)
    let save = UIAlertAction(title: "Save", style: .cancel) { action in
      guard let textFieldEmail = alert.textFields?[0], let emailtextField = textFieldEmail.text else { return }
      guard let textFieldDescription = alert.textFields?[1], let descriptionTextField = textFieldDescription.text else { return }
      guard let textFieldRating = alert.textFields?[2], let ratingTextField = textFieldRating.text else { return }
 
      let emailText = emailtextField == "" ? "No email" : emailtextField
      let descriptionText = descriptionTextField == "" ? "No description" : descriptionTextField
      let ratingValue = ratingTextField == "" ? 0 : Int(ratingTextField)
 
      completion(emailText, descriptionText, ratingValue!)
    }
 
    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alert.addTextField { textFieldEmail in
      textFieldEmail.placeholder = "Enter email.."
      textFieldEmail.keyboardType = .emailAddress
    }
    alert.addTextField { textFieldDescription in
      textFieldDescription.placeholder = "Enter description.."
    }
    alert.addTextField { textFieldRating in
      textFieldRating.placeholder = "Enter rating.."
      textFieldRating.keyboardType = .numberPad
    }
 
    alert.addAction(save)
    alert.addAction(cancel)
 
    controller.present(alert, animated: true)
  }
 
  func updateAlert(controller: UIViewController, usefulModel: UsefulConnectionModel, completion: @escaping (String, String, Int)->()){
    let alert = UIAlertController(title: "Update connection", message: "", preferredStyle: .alert)
    let update = UIAlertAction(title: "Update", style: .cancel) { action in
 
      guard let textFieldEmail = alert.textFields?[0], let emailtextField = textFieldEmail.text else { return }
      guard let textFieldDescription = alert.textFields?[1], let descriptionTextField = textFieldDescription.text else { return }
      guard let textFieldRating = alert.textFields?[2], let ratingTextField = textFieldRating.text else { return }
 
      let oldEmail = usefulModel.emailLabel
      let oldDescription = usefulModel.descriptionLabel
      let oldRating = usefulModel.ratingLabel.value!
 
      guard let emailText = emailtextField == "" ? oldEmail : emailtextField else { return }
      guard let descriptionText = descriptionTextField == "" ? oldDescription : descriptionTextField else { return }
      guard let ratingValue = ratingTextField == "" ? oldRating : Int(ratingTextField) else { return }
 
      completion(emailText, descriptionText, ratingValue)
    }
 
    alert.addTextField { textFieldEmail in
      textFieldEmail.placeholder = usefulModel.emailLabel
      textFieldEmail.keyboardType = .emailAddress
    }
    alert.addTextField { textFieldDescription in
      textFieldDescription.placeholder = usefulModel.descriptionLabel
    }
    alert.addTextField { textFieldRating in
      textFieldRating.placeholder = String(usefulModel.ratingLabel.value!)
      textFieldRating.keyboardType = .numberPad
    }
 
    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alert.addAction(update)
    alert.addAction(cancel)
 
    controller.present(alert, animated: true)
  }
}
