import UIKit

class ViewController: UIViewController {
    var circles: [UIView] = [] // массив для хранения представлений круга

    override func viewDidLoad() {
        super.viewDidLoad()
     
        //размер круга
        let circleSize: CGFloat = 80
        // цвета
        let circleColors: [UIColor] = [.red, .green, .blue, .yellow, .orange]
        
        // Цикл для создания и настройки каждого вида круга
        for i in 0..<5 { // рандомные позиции 5 кругов на экране
            let circle = UIView(frame: CGRect(x: randomXPosition(),
                                              y: randomYPosition(),
                                              width: circleSize,
                                              height: circleSize))
            
            // цвет берется из массива circleColors с индексом i
            circle.backgroundColor = circleColors[i]
            // форма круга
            circle.layer.cornerRadius = circleSize / 2
            
            // добавляем круги
            view.addSubview(circle)
            circles.append(circle)
            
            // распознаватель жестов, движение и перетаскивание
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            circle.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
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
 
    // Функция для обработки жеста панорамирования в виде круга
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let circle = gestureRecognizer.view else { return }
        
        switch gestureRecognizer.state {
        case .changed:
            let translation = gestureRecognizer.translation(in: view)
            circle.center = CGPoint(x: circle.center.x + translation.x, y: circle.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: view)
            
            // Проверка на пересечение с другими кругами
            checkForOverlap(circle)
            
        default:
            break
        }
    }
    
    // Функция для проверки наложения между кругом и другими кругами
    func checkForOverlap(_ circle: UIView) {
        for otherCircle in circles {
            if otherCircle != circle && circle.frame.intersects(otherCircle.frame) {
              
                // Анимируем слияние кругов и меняем цвет на фиолетовый
                UIView.animate(withDuration: 0.3) {
                    otherCircle.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                    otherCircle.alpha = 0
                    circle.backgroundColor = UIColor.systemIndigo
                    
                  // увеличение на 2%
                    let increasedSize = CGSize(width: circle.bounds.width * 1.02, height: circle.bounds.height * 1.02)
                    
                // максимальный размер
                    let maxWidth: CGFloat = 360
                    let maxHeight: CGFloat = 360
                    let constrainedSize = CGSize(width: min(increasedSize.width, maxWidth), height: min(increasedSize.height, maxHeight))
                    
                    let increasedOrigin = CGPoint(x: circle.center.x - constrainedSize.width / 2, y: circle.center.y - constrainedSize.height / 2)
                    let increasedFrame = CGRect(origin: increasedOrigin, size: constrainedSize)
                    
               // увеличение
                    circle.frame = increasedFrame
                    circle.layer.cornerRadius = constrainedSize.width / 2
                } completion: { _ in
                    otherCircle.removeFromSuperview()
                // завершение
                }
            }
        }
    }
}
