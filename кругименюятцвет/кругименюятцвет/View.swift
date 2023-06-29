//
//  View.swift
//  кругименюятцвет
//
//  Created by OneClick on 29/6/23.
//

/*
import Foundation
import UIKit

class ViewController: UIViewController {
    var circlesView: [UIImageView] = []
    var restartButton: UIButton!
    var musicButton: UIButton!
    var confettiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCircles()
    }
    
    private func setupUI() {
        // Background image setup
        
        let backgroundImage = UIImage(named: "circus")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        // Restart Button setup
        
        restartButton = UIButton(type: .system)
        restartButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        restartButton.center = view.center
        restartButton.layer.cornerRadius = 30
        restartButton.layer.shadowColor = UIColor.black.cgColor
        restartButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        restartButton.layer.shadowRadius = 10
        restartButton.layer.shadowOpacity = 0.5
        restartButton.layer.borderColor = UIColor.systemGreen.cgColor
        restartButton.layer.borderWidth = 2
        startPulseAnimation()
        view.addSubview(restartButton)
        
        // Other buttons setup
        
        musicButton = UIButton(type: .system)
        musicButton.frame = CGRect(x: 20, y: 40, width: 40, height: 40)
        musicButton.setTitle("🔔", for: .normal)
        view.addSubview(musicButton)
        
        confettiButton = UIButton(type: .system)
        confettiButton.frame = CGRect(x: view.bounds.width - 60, y: 40, width: 40, height: 40)
        confettiButton.setTitle("🎉", for: .normal)
        view.addSubview(confettiButton)
    }
    
    private func setupCircles() {
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
}


import UIKit
import AVFoundation 

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
    
 */
