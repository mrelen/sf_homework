//
//  Model.swift
//  кругименюятцвет
//
//  Created by OneClick on 29/6/23.
//

/*
import Foundation
import UIKit

class Circle {
    static func randomXPosition(viewWidth: CGFloat, circleSize: CGFloat) -> CGFloat {
        let randomX = CGFloat.random(in: circleSize...(viewWidth - circleSize))
        return randomX
    }
    
    static func randomYPosition(viewHeight: CGFloat, circleSize: CGFloat) -> CGFloat {
        let randomY = CGFloat.random(in: circleSize...(viewHeight - circleSize))
        return randomY
    }
    
    func checkForOverlap(_ circle: UIView) {
        for otherCircle in circles {
            if otherCircle != circle && circle.frame.intersects(otherCircle.frame) {
                // Анимируем слияние кругов и меняем цвет
                UIView.animate(withDuration: 0.3) {
                    otherCircle.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                    otherCircle.alpha = 0
                //   circle.backgroundColor = UIColor.systemIndigo

                    // увеличиваем размер на 2%
                    let increasedSize = CGSize(width: circle.bounds.width * 1.02, height: circle.bounds.height * 1.02)
                    
                    let maxWidth: CGFloat = 360
                    let maxHeight: CGFloat = 360

                    // ограничение размера maxWidth и maxHeight
                    let constrainedSize = CGSize(width: min(increasedSize.width, maxWidth), height: min(increasedSize.height, maxHeight))

                    // рассчитываем увеличенный кадр с центром в начале
                    let increasedOrigin = CGPoint(x: circle.center.x - constrainedSize.width / 2, y: circle.center.y - constrainedSize.height / 2)
                    let increasedFrame = CGRect(origin: increasedOrigin, size: constrainedSize)

                    // обновить рамку и угловой радиус
                    circle.frame = increasedFrame
                    circle.layer.cornerRadius = constrainedSize.width / 2
                } completion: { _ in
                    otherCircle.removeFromSuperview()
                    
                    // удаляем исключенный круг из массива кругов
                    self.circles.removeAll { $0 == otherCircle }
                    
                    // проверяем, остался ли только один круг
                    self.updateRestartButtonVisibility()
                }
            }
        }
    }
    
    func updateRestartButtonVisibility() {
        // Update the visibility of the restart button based on the circles
    }
    
    // Other circle-related properties and methods
}

*/
