//
//  ViewCell.swift
//  ProjectWithRealm
//
//  Created by OneClick on 1/9/23.
//

import UIKit
 
class UsefulConnectionCell: UITableViewCell {
 
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
 
  func configureCell(with model: UsefulConnectionModel){
    emailLabel.text = model.emailLabel
    descriptionLabel.text = model.descriptionLabel
    ratingLabel.text = model.ratingString()
  }
}
