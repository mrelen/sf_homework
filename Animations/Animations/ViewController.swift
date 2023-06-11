//
//  ViewController.swift
//  Animations
//
//  Created by OneClick on 8/6/23.
//

import UIKit
 
class ViewController: UIViewController {
 
    @IBOutlet weak var someView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func viewAnimate(_ sender: Any) {
        let start = self.someView.center
        
        UIView.animate(withDuration: 0.5) {
                   // Угол 45 градусов
                   let angle: CGFloat = 45.0 * CGFloat.pi / 180.0
                   // Создаем матрицу поворота
                   let rotationMatrix = CGAffineTransform(rotationAngle: angle)
                   // Создаем матрицу перемещения
                   let translationMatrix = CGAffineTransform(translationX: 80.0, y: 0.0)
                   // Трансформируем someView
                   self.someView.transform = rotationMatrix.concatenating(translationMatrix)
               } 
      //  UIView.animate(withDuration: 1) {
               // let angle: CGFloat = 45.0 * CGFloat.pi / 180.0
             //   self.someView.transform.c = cos(angle)
  //      }
 
       // UIView.animateKeyframes(withDuration: 5, delay: 0, options: .calculationModeCubic, animations: {
         //   UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
         //       self.someView.center = CGPoint(x: self.view.bounds.midX,
                                            //   y: self.view.bounds.minY)
            }
           // UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
             //   self.someView.center = CGPoint(x: self.view.bounds.midX,
                                             //  y: self.view.bounds.maxY)
            }
          //  UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
            //    self.someView.center = start
                
            //    self.someView.transform = self.someView.transform.scaledBy (x: 2, y: 2) //увеличение
             //поворот   self.someView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
          //  }
      //  })
//    }
    
