//
//  ViewController.swift
//  цирк
//
//  Created by OneClick on 4/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var circle3: UIView!
    @IBOutlet weak var circle4: UIView!
    @IBOutlet weak var circle5: UIView!

    var circles: [UIView] = []

    override func viewDidLoad() {
            super.viewDidLoad()
            
            let backgroundImage = UIImage(named: "цирк")
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.frame = view.bounds
            backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(backgroundImageView)
            view.sendSubviewToBack(backgroundImageView)
        
        // Set the image of circle1
        let circle1Image = UIImage(named: "красныймяч")
        let circle1ImageView = UIImageView(image: circle1Image)
        circle1ImageView.contentMode = .scaleAspectFill
        circle1ImageView.frame = circle1.bounds
        circle1ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Remove any existing subviews from circle1
        circle1.subviews.forEach { $0.removeFromSuperview() }
        
        // Add the image view to circle1
        circle1.addSubview(circle1ImageView)
        
        // Set the image of circle2
        let circle2Image = UIImage(named: "зеленыймяч")
        let circle2ImageView = UIImageView(image: circle2Image)
        circle2ImageView.contentMode = .scaleAspectFill
        circle2ImageView.frame = circle2.bounds
        circle2ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Remove any existing subviews from circle2
        circle2.subviews.forEach { $0.removeFromSuperview() }
        
        // Add the image view to circle2
        circle2.addSubview(circle2ImageView)
        
        
        // Set the image of circle3
        let circle3Image = UIImage(named: "синиймяч")
        let circle3ImageView = UIImageView(image: circle3Image)
        circle3ImageView.contentMode = .scaleAspectFill
        circle3ImageView.frame = circle3.bounds
        circle3ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Remove any existing subviews from circle3
        circle3.subviews.forEach { $0.removeFromSuperview() }
        
        // Add the image view to circle3
        circle3.addSubview(circle3ImageView)
        
        
        // Set the image of circle4
        let circle4Image = UIImage(named: "желтыймяч")
        let circle4ImageView = UIImageView(image: circle4Image)
        circle4ImageView.contentMode = .scaleAspectFill
        circle4ImageView.frame = circle4.bounds
        circle4ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Remove any existing subviews from circle4
        circle4.subviews.forEach { $0.removeFromSuperview() }
        
        // Add the image view to circle4
        circle4.addSubview(circle4ImageView)
        
        
        // Set the image of circle5
        let circle5Image = UIImage(named: "оранжевыймяч")
        let circle5ImageView = UIImageView(image: circle5Image)
        circle5ImageView.contentMode = .scaleAspectFill
        circle5ImageView.frame = circle5.bounds
        circle5ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Remove any existing subviews from circle5
        circle5.subviews.forEach { $0.removeFromSuperview() }
        
        // Add the image view to circle5
        circle5.addSubview(circle5ImageView)
        
        
        
        
        circles = [circle1, circle2, circle3, circle4, circle5]
        
        let circleColors: [UIColor] = [.red, .green, .blue, .yellow, .orange]
        
        for (index, circle) in circles.enumerated() {
            circle.backgroundColor = circleColors[index]
            circle.layer.cornerRadius = circle.bounds.height / 2
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            circle.addGestureRecognizer(panGestureRecognizer)
        }
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

