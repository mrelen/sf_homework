//последняя версия
//  ViewController.swift
//  Game2
//
//  Created by OneClick on 4/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    //создаем кнопки
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var circle3: UIView!
    @IBOutlet weak var circle4: UIView!
    @IBOutlet weak var circle5: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // добавляем распознаватель жестов
        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circle1.addGestureRecognizer(panGesture1)
        
        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circle2.addGestureRecognizer(panGesture2)
        
        let panGesture3 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circle3.addGestureRecognizer(panGesture3)
        
        let panGesture4 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circle4.addGestureRecognizer(panGesture4)
        
        let panGesture5 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circle5.addGestureRecognizer(panGesture5)
        
        // делаем вьюшки коуглыми
        circle1.layer.cornerRadius = circle1.bounds.height / 2
        circle2.layer.cornerRadius = circle2.bounds.height / 2
        circle3.layer.cornerRadius = circle3.bounds.height / 2
        circle4.layer.cornerRadius = circle4.bounds.height / 2
        circle5.layer.cornerRadius = circle5.bounds.height / 2
        
        // закругляем углы
        circle1.clipsToBounds = true
        circle2.clipsToBounds = true
        circle3.clipsToBounds = true
        circle4.clipsToBounds = true
        circle5.clipsToBounds = true
    }
    
    // здесь код написан совместо с ChatGPT, но хоть в Attributes Inspector, включен User Interaction Enabled, круги не обьединяются :(
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let draggedView = gesture.view else { return }
        
        switch gesture.state {
        case .began:
            // Bring the dragged view to the front
            view.bringSubviewToFront(draggedView)
            
        case .changed:
            // Move the dragged view with the gesture
            let translation = gesture.translation(in: view)
            draggedView.center = CGPoint(x: draggedView.center.x + translation.x,
                                         y: draggedView.center.y + translation.y)
            gesture.setTranslation(.zero, in: view)
            
        case .ended:
            // Check for collision with other blue circles
            for subview in view.subviews {
                if subview != draggedView, subview.backgroundColor == .blue,
                   subview.frame.intersects(draggedView.frame) {
                    // Increase size and change color of the intersecting circle
                    subview.backgroundColor = UIColor.systemIndigo
                    subview.transform = subview.transform.scaledBy(x: 1.5, y: 1.5)
                    
                    // Remove the dragged view from superview
                    draggedView.removeFromSuperview()
                    
                    // Combine all circles into one large circle
                    combineCircles()
                    break
                }
            }
            
        default:
            break
        }
    }
    
    func combineCircles() {
        // Get all the remaining blue circles
        let blueCircles = view.subviews.filter { $0.backgroundColor == .systemBlue }
        
        // If there are fewer than 2 blue circles left, return
        guard blueCircles.count >= 2 else { return }
        
        // Calculate the combined area and frame of all circles
        var combinedFrame = blueCircles[0].frame
        for i in 1..<blueCircles.count {
            combinedFrame = combinedFrame.union(blueCircles[i].frame)
        }
        
        // Calculate the radius of the new circle
        let newRadius = max(combinedFrame.width, combinedFrame.height) * 1.5 / 2.0
        
        // Remove all the blue circles
        for circle in blueCircles {
            circle.removeFromSuperview()
        }
        
        // Create a new circle with the combined area
        let newCircle = UIView(frame: CGRect(x: 0, y: 0, width: newRadius * 2, height: newRadius * 2))
        newCircle.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        newCircle.backgroundColor = UIColor.systemIndigo
        newCircle.layer.cornerRadius = newRadius
        newCircle.clipsToBounds = true
        
        // Add the new circle to the view
        view.addSubview(newCircle)
    }
}
