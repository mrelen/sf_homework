//
//  MyCollectionVC.swift
//  ExplorinacollectionView
//
//  Created by OneClick on 31/3/23.
//

import UIKit

private let reuseIdentifier = "ItemCell"
private let customReuseIdentifier = "CustomItemCell" // название переменной

struct StructCustomItem {
    let image: String
    let textOne: String
    let textTwo: String
}

struct  StructItem {
  let image: String
  let text: String
}

class MyCollectionVC: UICollectionViewController {
    
    var arrayItems = [StructItem]()
    var arrayCistomItem = [StructCustomItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: customReuseIdentifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: customReuseIdentifier)
        
        arrayItems.append(StructItem(image: "temp.darkYellow", text: "Dark yellow color"))
        arrayItems.append(StructItem(image: "temp.orange", text: "Orange color"))
        arrayItems.append(StructItem(image: "temp.red", text: "Red color"))
        
        
        
        arrayCistomItem.append(StructCustomItem(image: "temp.lightYellow", textOne: "Light yellow color", textTwo: "Item 1"))
        arrayCistomItem.append(StructCustomItem(image: "temp.orange", textOne: "Orange color", textTwo: "Item 2"))
        arrayCistomItem.append(StructCustomItem(image: "temp.red", textOne: "Red color", textTwo: "Item 3"))
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCistomItem.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customReuseIdentifier, for: indexPath) as? CustomItemCell {
          cell.imageView.image = UIImage(named: arrayCistomItem[indexPath.row].image)
          cell.labelTextOne.text = arrayCistomItem[indexPath.row].textOne
          cell.labelTextTwo.text = arrayCistomItem[indexPath.row].textTwo
          return cell
        }
        
        return UICollectionViewCell()
      }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
