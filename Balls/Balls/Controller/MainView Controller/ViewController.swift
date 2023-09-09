import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let gameModel: GameModel = GameModel()
    let confettiManager: ConfettiManager = ConfettiManager()
    
  
    var pictureImageView: UIImageView!
    var isPictureVisible = false
    var circleImageNames: [String] = ["red_circle", "green_circle", "blue_circle", "yellow_circle", "orange_circle"]
    var previousCircleColor: String?
    
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var confettiButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setting all the audio parameters for view controller
        gameModel.setAudioParameters()
        
        setBackgroundImage()
        setupCircles()
        
        // обрабатывает видимость и анимацию кнопки перезагрузки в зависимости от количества кругов, присутствующих на экране
        repositionPicture()
        updateRestartButtonVisibility()
        updatePictureVisibility()
        startBlinkingAnimation()
        startAddingCircles()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gameModel.audioPlayer?.play() // воспроизведения звука
    }
    
    
    // Method for setting background image
    //
    func setBackgroundImage() {
     
        // фоновое изображение
        let backgroundImageView = UIImageView(image: UIImage(named: "circus"))
        
        backgroundImageView.contentMode         = .scaleAspectFill // заполняем на весь экран
        backgroundImageView.frame               = view.bounds // рамки
        
        // автоматически изменять размер изображения при изменении размера представления
        
        //backgroundImageView.autoresizingMask    = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView) //отправляем изображение в конец иерархии, чтобы оно был фоном
        
        NSLayoutConstraint.activate([
        
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
        setTheProperties()
        
    }
    
    // Method for setting the properties
    //
    func setTheProperties() {
        
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
        
        // устанавливаем начальные круги
        view.addSubview(pictureImageView)
        
    }
    
    func startAddingCircles() {
        
        var circleCount = 0
        
        // Create a timer to add circles one by one
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            if self.restartButton.isHidden {
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
        let circleSize: CGFloat = 80
        
        
        let availableColors = circleImageNames.filter { $0 != previousCircleColor }
        
        
        guard let randomImageName = availableColors.randomElement() else {
            
            previousCircleColor = nil
            return
        }
        
        let circle = UIImageView(frame: CGRect(x: randomXPosition(),
                                               y: randomYPosition(),
                                               width: circleSize,
                                               height: circleSize))
        
        // Assign the image based on the chosen color
        circle.image = UIImage(named: randomImageName)
        
        circle.contentMode = .scaleAspectFill
        view.addSubview(circle)
        gameModel.circles.append(circle)
        
        // Store the color of the current circle as the previous color
        previousCircleColor = randomImageName
        
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
            gameModel.circles.append(circle) // добавляет круг в массив circles, который отслеживает все созданные круги
            
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
       
        for otherCircle in gameModel.circles {
            
            if otherCircle != circle && circle.frame.intersects(otherCircle.frame) {
               
                // звук лопающихся шариков
                gameModel.explosionAudioPlayer?.play()
                
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
                    self.gameModel.circles.removeAll { $0 == otherCircle }
                    
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
        
        if gameModel.circles.count == 1 {
            
            let lastCircle = gameModel.circles[0]
            
            if lastCircle.alpha == 1 {
                // анимируем непрозрачность последнего круга до 0
                UIView.animate(withDuration: 2.5, animations: {
                    lastCircle.alpha = 0
                }) { _ in
                    self.removeLastCircle()
                }
                
            }
            
        }
        
        restartButton.isHidden = gameModel.circles.count != 1
        
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
        
        if let lastCircle = gameModel.circles.last {
            lastCircle.removeFromSuperview()
            gameModel.circles.removeLast()
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
        if gameModel.audioPlayer?.isPlaying == true {
            gameModel.audioPlayer?.pause()
        } else {
            gameModel.audioPlayer?.play()
        }

        musicButton.updateMusicButtonTitle(isPlaying: gameModel.audioPlayer?.isPlaying == true)
    }
    
    @IBAction func toggleConfetti(_ sender: UIButton) {
        confettiManager.toggleConfetti(inView: view, amount: 10)
        confettiButton.updateConfettiButtonTitle(isConfettiEnabled: confettiManager.isConfettiEnabled)
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
            for circle in self.gameModel.circles {
                circle.removeFromSuperview()
            }
            // Очищаем массив кругов
            self.gameModel.circles.removeAll()
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
