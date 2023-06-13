//
//  Confetti.swift
//  кругименюятцвет
//
//  Created by OneClick on 13/6/23.
//

import Foundation
import UIKit

class Confetti: UIViewController {
    var isFingerOnScreen = false
    var confettiViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            isFingerOnScreen = true
            dropConfetti(amount: 30)
        } else if gesture.state == .ended {
            isFingerOnScreen = false
        }
    }
    
    func dropConfetti(amount: Int) {
        guard isFingerOnScreen else { return }
        
        let screenBounds = UIScreen.main.bounds
        for _ in 1...amount {
            let confettiView = UIView(frame: CGRect(x: CGFloat.random(in: 0...screenBounds.width),
                                                    y: CGFloat.random(in: 0...screenBounds.height),
                                                    width: 10,
                                                    height: 10))
            confettiView.backgroundColor = UIColor.random()
            confettiView.layer.cornerRadius = 5
            view.addSubview(confettiView)
            confettiViews.append(confettiView)
            
            let animationDuration: TimeInterval = Double.random(in: 1...3)
            let randomX = CGFloat.random(in: 0...screenBounds.width)
            let randomY = CGFloat.random(in: 0...screenBounds.height)
            let endPoint = CGPoint(x: randomX, y: screenBounds.height + 50 + randomY)
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveLinear, animations: {
                confettiView.frame.origin = endPoint
            }) { (_) in
                confettiView.removeFromSuperview()
                if let index = self.confettiViews.firstIndex(of: confettiView) {
                    self.confettiViews.remove(at: index)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dropConfetti(amount: amount)
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
