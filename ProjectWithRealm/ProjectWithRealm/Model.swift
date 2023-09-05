//
//  Model.swift
//  ProjectWithRealm
//
//  Created by OneClick on 1/9/23.
//

import RealmSwift
 
 class UsefulConnectionModel: Object  {
  @objc dynamic var emailLabel: String? = nil
  @objc dynamic var descriptionLabel: String? = nil
  let ratingLabel = RealmOptional<Int>()
 
  convenience init(email: String?, description: String?, rating: Int?) {
    self.init()
    emailLabel = email
    descriptionLabel = description
    ratingLabel.value = rating
  }
 
  func ratingString() -> String? {
    guard let value = ratingLabel.value else { return nil }
    return String(value)
  }
}
