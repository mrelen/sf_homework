import UIKit
import AVFoundation

class ViewController: UIViewController {
    var circles: [UIView] = []
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var restartButton: UIButton! // кнопка перезапуска
    @IBOutlet weak var musicButton: UIButton! // кнопка плеера
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // настраивает аудиоплеер на воспроизведение файла из new group assets
        if let audioPath = Bundle.main.path(forResource: "Color Clownies - Circus (320 kbps)", ofType: "mp3") {
                   let audioURL = URL(fileURLWithPath: audioPath)
                   audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
               }
        
        // фоновое изображение
        let backgroundImage = UIImage(named: "circus")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill // заполняем на весь экран
        backgroundImageView.frame = view.bounds // рамки
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // автоматически изменять размер изображения при изменении размера представления
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView) //отправляем изображение в конец иерархии, чтобы оно был фоном
        
        
        
        restartButton.isHidden = true
        
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
        startPulseAnimation()
  //     UIButton.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
   //        self.restartButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
    //  }, completion: nil)
        
        
        
        // устанавливаем начальные круги
        setupCircles()
        // обрабатывает видимость и анимацию кнопки перезагрузки в зависимости от количества кругов, присутствующих на экране
        updateRestartButtonVisibility()
    }
    
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
            
            view.addSubview(circle) // добавляет круг в качестве подвида к основному виду
            circles.append(circle) // добавляет круг в массив circles, который отслеживает все созданные круги
            
            // позволяет перетаскивать и перемещать круги
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            circle.addGestureRecognizer(panGestureRecognizer)
            
            // устанавливает свойство круга isUserInteractionEnabled в значение true, разрешая взаимодействие с пользователем в круге
            circle.isUserInteractionEnabled = true
            // устанавливает угловой радиус слоя, чтобы он выглядел как круг
            circle.layer.cornerRadius = circleSize / 2
            circle.clipsToBounds = true // обрезаем содержимое за пределами круга
            
            // устанавливает фильтр минимизации и увеличения слоя круга на «трилинейный»
            circle.layer.minificationFilter = .trilinear
            circle.layer.magnificationFilter = .trilinear
        }
        audioPlayer?.play() // воспроизведения звука
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
        
        view.bringSubviewToFront(restartButton)

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
    
    
    // функция для обновления видимости кнопки перезапуска
    func updateRestartButtonVisibility() {
        if circles.count == 1 {
            let lastCircle = circles[0]
            
            if lastCircle.alpha == 1 {
                // анимируем непрозрачность последнего круга до 0
                UIView.animate(withDuration: 2.5, animations: {
                    lastCircle.alpha = 0
                }) { _ in
                    self.removeLastCircle()
                }
            }
        }
        
        restartButton.isHidden = circles.count != 1
        
        // перезапустить анимацию пульсации кнопки, если кнопка видна
        if !restartButton.isHidden {
            startPulseAnimation()
        } else {
            restartButton.layer.removeAllAnimations()
        }
    }

    // функция для удаления последнего круга из представления и массива кругов
    func removeLastCircle() {
        if let lastCircle = circles.last {
            lastCircle.removeFromSuperview()
            circles.removeLast()
        }
    }

    
    // запуск пульсирующей анимации на кнопке перезагрузки
    func startPulseAnimation() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.5
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.05
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        restartButton.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }

    
    
    // музыка включается сразу и ее можно остановить кнопкой в правом углу экрана
       @IBAction func toggleMusic(_ sender: UIButton) {
              if audioPlayer?.isPlaying == true {
                  audioPlayer?.pause()
                  musicButton.setTitle("🔕", for: .normal) // стоп
              } else {
                  audioPlayer?.play()
                  musicButton.setTitle("🔔", for: .normal) // плэй
              }
          }
    
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        // удалить существующие круги из представления
        for circle in circles {
            circle.removeFromSuperview()
        }
        
        // очистить массив кругов
        circles.removeAll()
        
        // снова устанавливаем круги
        setupCircles()
    }
}

