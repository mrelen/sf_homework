//
//  ViewController.swift
//  цирк
//
//  Created by OneClick on 4/6/23.
//

import UIKit

// я установила только портретную ориентацию
class ViewController: UIViewController {
    
    //кнопки
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var circle3: UIView!
    @IBOutlet weak var circle4: UIView!
    @IBOutlet weak var circle5: UIView!
    @IBOutlet weak var restartButton: UIButton!
    
    var circles: [UIView] = [] // массив для хранения представлений шариков
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartButton.isHidden = true // кнопка скрыта
        
        restartButton.layer.cornerRadius = 30
        // скругление углов кнопки
           restartButton.layer.shadowColor = UIColor.black.cgColor
        // черный цвет тени
           restartButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        // смещение тени от кнопки
           restartButton.layer.shadowRadius = 10
        // радиусом размытия тени
        restartButton.layer.shadowOpacity = 0.5
        // регулирует прозрачность тени
        restartButton.layer.borderColor = UIColor.systemGreen.cgColor
        // цвет обводки
        restartButton.layer.borderWidth = 2
        // ширина линии обводки
        UIButton.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.restartButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: nil)
        // анимация кнопки (пульс, увеличивается-уменьшается), работает с ошибкой
        
        
        // Настройка вида фонового изображения. Изначально там были системные цвета, все как надо по условию, но я сделала по дефолту, чтобы это не отвлекало меня
        let backgroundImage = UIImage(named: "цирк")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        
        
        // Настройка представления изображения для каждого круга
        // CIRCLE 1
        let circle1Image = UIImage(named: "красныймяч")
        let circle1ImageView = UIImageView(image: circle1Image)
        circle1ImageView.contentMode = .scaleAspectFill
        circle1ImageView.frame = circle1.bounds
        circle1ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Удаляем все существующие подпредставления из circle1
        circle1.subviews.forEach { $0.removeFromSuperview() }
        
        // Добавляем представление изображения в circle1
        circle1.addSubview(circle1ImageView)
        
        
        // CIRCLE 2
        let circle2Image = UIImage(named: "зеленыймяч")
        let circle2ImageView = UIImageView(image: circle2Image)
        circle2ImageView.contentMode = .scaleAspectFill
        circle2ImageView.frame = circle2.bounds
        circle2ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Удаляем все существующие подпредставления из circle2
        circle2.subviews.forEach { $0.removeFromSuperview() }
        
        // Добавляем представление изображения в circle2
        circle2.addSubview(circle2ImageView)
        
        
        // CIRCLE 3
        let circle3Image = UIImage(named: "синиймяч")
        let circle3ImageView = UIImageView(image: circle3Image)
        circle3ImageView.contentMode = .scaleAspectFill
        circle3ImageView.frame = circle3.bounds
        circle3ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Удаляем все существующие подпредставления из circle3
        circle3.subviews.forEach { $0.removeFromSuperview() }
        
        // обавляем представление изображения в circle3
        circle3.addSubview(circle3ImageView)
        
        
        // CIRCLE 4
        let circle4Image = UIImage(named: "желтыймяч")
        let circle4ImageView = UIImageView(image: circle4Image)
        circle4ImageView.contentMode = .scaleAspectFill
        circle4ImageView.frame = circle4.bounds
        circle4ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Удаляем все существующие подпредставления из circle4
        circle4.subviews.forEach { $0.removeFromSuperview() }
        
        // Добавляем представление изображения в circle4
        circle4.addSubview(circle4ImageView)
        
        
        // CIRCLE 5
        let circle5Image = UIImage(named: "оранжевыймяч")
        let circle5ImageView = UIImageView(image: circle5Image)
        circle5ImageView.contentMode = .scaleAspectFill
        circle5ImageView.frame = circle5.bounds
        circle5ImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Удаляем все существующие подпредставления из circle5
        circle5.subviews.forEach { $0.removeFromSuperview() }
        
        // Добавляем представление изображения в circle5
        circle5.addSubview(circle5ImageView)
        
        
        
        // создаем массив с именем «circles» и присваивает ему вьюшки «circle1...4». Эти экземпляры соединены как аутлеты на сториборде.
        circles = [circle1, circle2, circle3, circle4, circle5]
        
        //изначально я пользовалась этими цветами, пока не загрузила изображения
        let circleColors: [UIColor] = [.red, .green, .blue, .yellow, .orange]
        
        // извлекает цвета из массива и делает края круглыми
        for (index, circle) in circles.enumerated() {
            circle.backgroundColor = circleColors[index]
            circle.layer.cornerRadius = circle.bounds.height / 2
            
            // распознаватель жестов, перетаскивание кругов
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            circle.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        // сброс состояния кругов
        circles.forEach { circle in // выполняется итерация по каждому элементу, цикл
            circle.transform = .identity // сброс трансформации
            circle.alpha = 1 // делает круг непрозрачным
        }
        
        // удаляем все существующие анимации
        circles.forEach { circle in
            circle.layer.removeAllAnimations()
        }
        
        // снова скрываем кнопку перезагрузки
        restartButton.isHidden = true
    }

    
    // проверка того, пересекается ли шарик с какими-либо другими шариками, и функция отвечает за выполнение необходимых действий. Здесь мне помог chatgpt. Он добавил анимацию по заданым условиям, я хотела, чтобы шарик обьединялись и новый шарик увеличивался на 2%, а его максимальный размер был 360х360
    
    //перемещение по Х и У
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
    
    func checkForOverlap(_ circle: UIView) { // перекрытие
        for otherCircle in circles {
            if otherCircle != circle && circle.frame.intersects(otherCircle.frame) {
                // Объедините шариков в один
                UIView.animate(withDuration: 0.3) {
                    otherCircle.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                    otherCircle.alpha = 0
                    circle.backgroundColor = UIColor.systemIndigo
                    
                    // Увеличение объединенного круга на 2%
                    let increasedSize = CGSize(width: circle.bounds.width * 1.02, height: circle.bounds.height * 1.02)
                    
                    // Проверка, превышает ли увеличенный размер максимальное ограничение размера
                    let maxWidth: CGFloat = 360
                    let maxHeight: CGFloat = 360
                    let constrainedSize = CGSize(width: min(increasedSize.width, maxWidth), height: min(increasedSize.height, maxHeight))
                    
                    let increasedOrigin = CGPoint(x: circle.center.x - constrainedSize.width / 2, y: circle.center.y - constrainedSize.height / 2)
                    let increasedFrame = CGRect(origin: increasedOrigin, size: constrainedSize)
                    
                    // регулируем рамку и угловой радиус объединенного круга
                    circle.frame = increasedFrame
                    circle.layer.cornerRadius = constrainedSize.width / 2
                } completion: { _ in
                    otherCircle.removeFromSuperview()
   
                    // новый код, анимация (ичезновение шариков)
                    if self.circles.last == otherCircle {
                       
                        let animation = CABasicAnimation(keyPath: "opacity")
                        animation.fromValue = 1
                        animation.toValue = 0
                        animation.duration = 2
                        animation.autoreverses = false
                        animation.fillMode = .forwards
                        animation.isRemovedOnCompletion = false
                        circle.layer.add(animation, forKey: "changeOpacity")
                        
                       
                        self.circles.removeLast() //удаление последнего из области видимости
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.restartButton.isHidden = false
                        }
                    }
                }
            }
        }
    }
}
