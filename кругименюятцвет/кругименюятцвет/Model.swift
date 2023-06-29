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
   
    }
    

}



import UIKit
import AVFoundation

class Item {
    var circles: [UIView] = []
    var audioPlayer: AVAudioPlayer?
    var isConfettiEnabled = false
    var confettiViews: [UIView] = []
}

class Model {
    @IBOutlet weak var restartButton: UIButton! // кнопка перезапуска (размер выравнять)
    @IBOutlet weak var musicButton: UIButton! // кнопка плеера (создать цикл)
    @IBOutlet weak var confettiButton: UIButton! // кнопка конфетти
    
    // создание и настройка серии кругов на экране
     func setupCircles() {
         let circleSize: CGFloat = 80
         let circleImageNames: [String] = ["red_circle", "green_circle", "blue_circle", "yellow_circle", "orange_circle"]
         
         // перебор и создание рандомных кругов, задается рамка
         for i in 0..<5 {
             let circle = UIImageView(frame: CGRect(x: randomXPosition(),
                                                    y: randomYPosition(),
                                                    width: circleSize,
                                                    height: circleSize))
             
             // присваивает соответствующее изображение из массива circleImageNames свойству image круга
             circle.image = UIImage(named: circleImageNames[i])
             //устанавливает режим содержимого круга на .scaleAspectFill, который определяет, как масштабируется изображение круга, чтобы оно соответствовало его рамке
             circle.contentMode = .scaleAspectFill
   
             
             // рандомная позиция по Х
             func randomXPosition() -> CGFloat {
                 let viewWidth = view.bounds.width
                 let circleSize: CGFloat = 80
                 let randomX = CGFloat.random(in: circleSize...(viewWidth - circleSize))
                 return randomX
             }
             
             // рандомная позиция по У
             func randomYPosition() -> CGFloat {
                 let viewHeight = view.bounds.height
                 let circleSize: CGFloat = 80
                 let randomY = CGFloat.random(in: circleSize...(viewHeight - circleSize))
                 return randomY
             }
}
 */
