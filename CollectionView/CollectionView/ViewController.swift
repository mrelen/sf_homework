//
//  ViewController.swift
//  CollectionView
//
//  Created by OneClick on 3/4/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    

    @IBOutlet weak var collectionViewOne: UICollectionView!
    
    @IBOutlet weak var collectionViewTwo: UICollectionView!
    
    let arrayTemperature = ["temp.green",
    "temp.blackGreen",
    "temp.lightYellow",
    "temp.darkYellow",
    "temp.orange",
    "temp.red"]
    
    let arraySmiles = ["favorite",
    "nice",
    "routine",
    "notPleasant",
    "bad",
    "hate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShowImageVC") as? ShowImageVC
        else {
            return
        }
        var currentSelectedImage: String!
        
        if collectionView == collectionViewOne {
            currentSelectedImage = arrayTemperature[indexPath.row]
        }
        
        if collectionView == collectionViewTwo {
            currentSelectedImage = arraySmiles[indexPath.row]
        }
        
        vc.setImageName(name: currentSelectedImage)
        present(vc, animated: true, completion: nil)
        
        currentSelectedImage = arrayTemperature[indexPath.row]
        vc.setImageName(name: currentSelectedImage)
        
        present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewOne {
            return arrayTemperature.count
        }
        if collectionView == collectionViewTwo {
            return arraySmiles.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewOne {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOne", for: indexPath) as? Cell {
                
                let imageName = arrayTemperature[indexPath.row]
                cell.setTemperatureImage(tempName: imageName)
                return cell
            }
        }
        if collectionView == collectionViewTwo {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as? Cell {
                
                let imageName = arraySmiles[indexPath.row]
                cell.setSmileImage(smileName: imageName)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

