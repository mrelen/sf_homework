//
//  Confetty.swift
//  Balls
//
//  Created by OneClick on 7/9/23.
//


import UIKit

class ConfettiManager {
    var confettiViews: [UIView] = []
    var isConfettiEnabled = false
    var isDroppingConfetti = false
    
    
    // Toggle confetti
    func toggleConfetti(inView view: UIView, amount: Int) {
        isConfettiEnabled.toggle()
        
        if isConfettiEnabled {
            isDroppingConfetti = true
            dropConfetti(inView: view, amount: amount)
        } else {
            isDroppingConfetti = false
        }
    }
    
    // Drop confetti
    func dropConfetti(inView view: UIView, amount: Int) {
        guard isDroppingConfetti else { return }
        
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
            self.dropConfetti(inView: view, amount: amount)
        }
    }
    
    // Remove all confetti
    private func removeAllConfetti() {
        for confettiView in confettiViews {
            confettiView.removeFromSuperview()
        }
        confettiViews.removeAll()
    }
}

// UIColor randomization extension
extension UIColor {
    static func random() -> UIColor {
        let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple, .cyan, .magenta]
        let randomIndex = Int.random(in: 0..<colors.count)
        return colors[randomIndex]
    }
}


