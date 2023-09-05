import UIKit
import AVFoundation

class ViewController: UIViewController {
    var circles: [UIView] = []   // закрыть протоколом
    var audioPlayer: AVAudioPlayer?
    var explosionAudioPlayer: AVAudioPlayer?
    var isConfettiEnabled = false
    var confettiViews: [UIView] = []
    var pictureImageView: UIImageView!
    var isPictureVisible = false
    
    @IBOutlet weak var restartButton: UIButton! // кнопка перезапуска
    @IBOutlet weak var musicButton: UIButton! // кнопка плеера
    @IBOutlet weak var confettiButton: UIButton! // кнопка конфетти
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // настраивает аудиоплеер на воспроизведение файла из new group assets, музыка в цикле
        if let audioPath = Bundle.main.path(forResource: "Color Clownies - Circus (320 kbps)", ofType: "mp3") {
               let audioURL = URL(fileURLWithPath: audioPath)
               
               do {
                   audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                   audioPlayer?.numberOfLoops = -1 // количество циклов = -1 для бесконечного цикла
                   audioPlayer?.prepareToPlay()
               } catch {
                   print("Не удалось инициализировать аудиоплеер: \(error)")
               }
           }
        
        // звук лопающихся шариков
        if let explosionAudioPath = Bundle.main.path(forResource: "circle_explosion", ofType: "mp3") {
            let explosionAudioURL = URL(fileURLWithPath: explosionAudioPath)
            
            do {
                explosionAudioPlayer = try AVAudioPlayer(contentsOf: explosionAudioURL)
                explosionAudioPlayer?.prepareToPlay()
            } catch {
                print("Не удалось инициализировать аудиоплеер для circle_explosion: \(error)")
            }
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
        
        
        pictureImageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
                pictureImageView.image = UIImage(named: "picture")
                pictureImageView.contentMode = .scaleAspectFit
                view.addSubview(pictureImageView)
        // устанавливаем начальные круги
      
        setupCircles()
        // обрабатывает видимость и анимацию кнопки перезагрузки в зависимости от количества кругов, присутствующих на экране
        repositionPicture()
        updateRestartButtonVisibility()
        updatePictureVisibility()
        startBlinkingAnimation()
        startAddingCircles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        audioPlayer?.play() // воспроизведения звука
    }
    
    
    func startAddingCircles() {
        var circleCount = 0
        
        // Create a timer to add circles one by one
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.restartButton.isHidden && circleCount < 100 {
                self.addCircle()
                circleCount += 1
            } else {
                timer.invalidate() // Stop the timer after adding 100 circles or if the restart button is visible
                self.showRestartButton()
            }
        }
    }

    
    func showRestartButton() {
        DispatchQueue.main.async {
            self.restartButton.isHidden = false
            self.updatePictureVisibility()
        }
    }


    func addCircle() {
        // Create and configure a new circle view
        let circleSize: CGFloat = 80
        let circleImageNames: [String] = ["red_circle", "green_circle", "blue_circle", "yellow_circle", "orange_circle"]

        let circle = UIImageView(frame: CGRect(x: randomXPosition(),
                                               y: randomYPosition(),
                                               width: circleSize,
                                               height: circleSize))

        // Assign a random image from the array of circleImageNames
        if let randomImageName = circleImageNames.randomElement() {
            circle.image = UIImage(named: randomImageName)
        }

        circle.contentMode = .scaleAspectFill
        view.addSubview(circle)
        circles.append(circle)

        // Add a pan gesture recognizer to enable dragging the circle
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circle.addGestureRecognizer(panGestureRecognizer)
        
        // Enable user interaction for the circle view
        circle.isUserInteractionEnabled = true
        
        // Set corner radius to make it look like a circle
        circle.layer.cornerRadius = circleSize / 2
        circle.clipsToBounds = true
        
        // Set minification and magnification filters for the circle's layer
        circle.layer.minificationFilter = .trilinear
        circle.layer.magnificationFilter = .trilinear
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
        
    }



    
    
    // рандомная позиция кругов по Х
    func randomXPosition() -> CGFloat {
        let viewWidth = view.bounds.width
        let circleSize: CGFloat = 80
        let randomX = CGFloat.random(in: circleSize...(viewWidth - circleSize))
        return randomX
    }
    
    // рандомная позиция кругов по У
    func randomYPosition() -> CGFloat {
        let viewHeight = view.bounds.height
        let circleSize: CGFloat = 80
        let randomY = CGFloat.random(in: circleSize...(viewHeight - circleSize))
        return randomY
    }
 
    // Функция для обработки жеста панорамирования в виде круга
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        view.bringSubviewToFront(restartButton)
        view.bringSubviewToFront(musicButton)
        view.bringSubviewToFront(confettiButton)
        

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
               // звук лопающихся шариков
                explosionAudioPlayer?.play()
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
    
    // условие: салют запускается, когда видна кнопка рестарт
    func updatePictureVisibility() {
         pictureImageView.isHidden = restartButton.isHidden
     }
    
    // анимация салюта
    func startBlinkingAnimation() {
        if !isPictureVisible {
            isPictureVisible = true
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.pictureImageView.alpha = 0
            }, completion: nil)
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
        // запускать салют, если кнопка видна
        updatePictureVisibility()
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
    
    // рандомная позиция салюта
    func repositionPicture() {
        let randomX = CGFloat.random(in: 0...(view.bounds.width - pictureImageView.bounds.width))
        let randomY = CGFloat.random(in: 0...(view.bounds.height - pictureImageView.bounds.height))
        pictureImageView.frame.origin = CGPoint(x: randomX, y: randomY)
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
    
    @IBAction func toggleConfetti (_ sender: UIButton) {
        isConfettiEnabled = !isConfettiEnabled
        
        if isConfettiEnabled {
            confettiButton.setTitle("🎉", for: .normal)
            dropConfetti(amount: 10)
        } else {
            confettiButton.setTitle("🎉", for: .normal)
        }
    }
    
    func dropConfetti(amount: Int) {
        guard isConfettiEnabled else { return }
        
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
    
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        // анимация исчезновения салюта (ошибка, не работает)
        isPictureVisible = false

        UIView.animate(withDuration: 0.5, animations: {
    
            self.pictureImageView.alpha = 0
        }) { _ in
            self.pictureImageView.alpha = 1
            self.repositionPicture()
            
            // Удаляем существующие круги из вью
            for circle in self.circles {
                circle.removeFromSuperview()
            }
            // Очищаем массив кругов
            self.circles.removeAll()
            // Снова устанавливаем круги
            self.setupCircles()
            // Обновляем видимость кнопки перезапуска
            self.updateRestartButtonVisibility()
            // Снова запускаем анимацию мигания
            self.startBlinkingAnimation()
            // Снова запускаем создание кругов
            self.startAddingCircles()
        }
    }
}

// цвета конфетти
extension UIColor {
    static func random() -> UIColor {
        let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple, .cyan, .magenta]
        let randomIndex = Int.random(in: 0..<colors.count)
        return colors[randomIndex]
    }
}
