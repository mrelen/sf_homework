//
//  ViewController.swift
//  СolorСhange
//
//  Created by OneClick on 8/6/23.
//

import UIKit

class ViewController: UIViewController {
    var circles: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circleSize: CGFloat = 80
        let circleColors: [UIColor] = [.red, .green, .blue, .yellow, .orange]
        
        for i in 0..<5 {
            let circle = UIView(frame: CGRect(x: randomXPosition(),
                                              y: randomYPosition(),
                                              width: circleSize,
                                              height: circleSize))
            circle.backgroundColor = circleColors[i]
            circle.layer.cornerRadius = circleSize / 2
            view.addSubview(circle)
            circles.append(circle)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            circle.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    func randomXPosition() -> CGFloat {
        let viewWidth = view.bounds.width
        let circleSize: CGFloat = 80
        let randomX = CGFloat.random(in: circleSize...(viewWidth - circleSize))
        return randomX
    }
    
    func randomYPosition() -> CGFloat {
        let viewHeight = view.bounds.height
        let circleSize: CGFloat = 80
        let randomY = CGFloat.random(in: circleSize...(viewHeight - circleSize))
        return randomY
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let circle = gestureRecognizer.view else { return }
        
        switch gestureRecognizer.state {
        case .changed:
            let translation = gestureRecognizer.translation(in: view)
            circle.center = CGPoint(x: circle.center.x + translation.x, y: circle.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: view)
            
            checkForOverlap(circle)
            
        default:
            break
        }
    }
    
    func checkForOverlap(_ circle: UIView) {
        for otherCircle in circles {
            if otherCircle != circle && circle.frame.intersects(otherCircle.frame) {
                // Merge the circles into one
                UIView.animate(withDuration: 0.3) {
                    otherCircle.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                    otherCircle.alpha = 0
                    circle.backgroundColor = UIColor.systemIndigo
                    
                    // Increase the size of the merged circle by 2%
                    let increasedSize = CGSize(width: circle.bounds.width * 1.02, height: circle.bounds.height * 1.02)
                    
                    // Check if the increased size exceeds the maximum size constraint
                    let maxWidth: CGFloat = 360
                    let maxHeight: CGFloat = 360
                    let constrainedSize = CGSize(width: min(increasedSize.width, maxWidth), height: min(increasedSize.height, maxHeight))
                    
                    let increasedOrigin = CGPoint(x: circle.center.x - constrainedSize.width / 2, y: circle.center.y - constrainedSize.height / 2)
                    let increasedFrame = CGRect(origin: increasedOrigin, size: constrainedSize)
                    
                    // Adjust the frame and corner radius of the merged circle
                    circle.frame = increasedFrame
                    circle.layer.cornerRadius = constrainedSize.width / 2
                } completion: { _ in
                    otherCircle.removeFromSuperview()
                }
            }
        }
    }
}


