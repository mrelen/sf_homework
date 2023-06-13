import UIKit
import AVFoundation

class ViewController: UIViewController {
    var circles: [UIView] = []
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var restartButton: UIButton! // Outlet for the restart button
    @IBOutlet weak var musicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let audioPath = Bundle.main.path(forResource: "Color Clownies - Circus (320 kbps)", ofType: "mp3") {
                   let audioURL = URL(fileURLWithPath: audioPath)
                   audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
               }
        
        
        let backgroundImage = UIImage(named: "circus")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        
        
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
        
        
        
        // Set up the initial circles
        setupCircles()
        
        updateRestartButtonVisibility()
    }
    
    func setupCircles() {
        let circleSize: CGFloat = 80
        let circleImageNames: [String] = ["red_circle", "green_circle", "blue_circle", "yellow_circle", "orange_circle"]
        
        for i in 0..<5 {
            let circle = UIImageView(frame: CGRect(x: randomXPosition(),
                                                   y: randomYPosition(),
                                                   width: circleSize,
                                                   height: circleSize))
            
            circle.image = UIImage(named: circleImageNames[i])
            circle.contentMode = .scaleAspectFill
            
            view.addSubview(circle)
            circles.append(circle)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            circle.addGestureRecognizer(panGestureRecognizer)
            
            circle.isUserInteractionEnabled = true
            circle.layer.cornerRadius = circleSize / 2
            circle.clipsToBounds = true // Clip the content outside the circle bounds
            
            circle.layer.minificationFilter = .trilinear
            circle.layer.magnificationFilter = .trilinear
        }
        audioPlayer?.play()
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
                // Animate the merging of circles and change the color to violet
                UIView.animate(withDuration: 0.3) {
                    otherCircle.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                    otherCircle.alpha = 0
                //   circle.backgroundColor = UIColor.systemIndigo

                    // Increase size by 2%
                    let increasedSize = CGSize(width: circle.bounds.width * 1.02, height: circle.bounds.height * 1.02)
                    
                    let maxWidth: CGFloat = 360
                    let maxHeight: CGFloat = 360

                    // Constrain size to maxWidth and maxHeight
                    let constrainedSize = CGSize(width: min(increasedSize.width, maxWidth), height: min(increasedSize.height, maxHeight))

                    // Calculate increased frame with centered origin
                    let increasedOrigin = CGPoint(x: circle.center.x - constrainedSize.width / 2, y: circle.center.y - constrainedSize.height / 2)
                    let increasedFrame = CGRect(origin: increasedOrigin, size: constrainedSize)

                    // Update frame and corner radius
                    circle.frame = increasedFrame
                    circle.layer.cornerRadius = constrainedSize.width / 2
                } completion: { _ in
                    otherCircle.removeFromSuperview()
                    
                    // Remove the eliminated circle from the circles array
                    self.circles.removeAll { $0 == otherCircle }
                    
                    // Check if there is only one circle remaining
                    self.updateRestartButtonVisibility()
                }
            }
        }
    }
    
    
    // Function to update the visibility of the restart button
    func updateRestartButtonVisibility() {
        if circles.count == 1 {
            let lastCircle = circles[0]
            
            if lastCircle.alpha == 1 {
                // Animate the last circle's opacity to 0
                UIView.animate(withDuration: 2, animations: {
                    lastCircle.alpha = 0
                }) { _ in
                    self.removeLastCircle()
                }
            }
        }
        
        restartButton.isHidden = circles.count != 1
        
        // Restart the button pulsing animation if the button is visible
        if !restartButton.isHidden {
            startPulseAnimation()
        } else {
            restartButton.layer.removeAllAnimations()
        }
    }

    // Function to remove the last circle from the view and the circles array
    func removeLastCircle() {
        if let lastCircle = circles.last {
            lastCircle.removeFromSuperview()
            circles.removeLast()
        }
    }

    
    // Function to start the pulsing animation on the restart button
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
        // Remove existing circles from the view
        for circle in circles {
            circle.removeFromSuperview()
        }
        
        // Clear the circles array
        circles.removeAll()
        
        // Set up the circles again
        setupCircles()
    }
}

