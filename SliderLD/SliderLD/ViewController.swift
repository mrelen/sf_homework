//
//  ViewController.swift
//  SliderLD
//
//  Created by OneClick on 10/7/23.
//


import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView()
    let slider = UISlider()

    let lightImage = UIImage(named: "light")
    let darkImage = UIImage(named: "dark")

    var isDarkMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadSettings()
    }

    func setupUI() {
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        
       /* constraint для imageView, чтобы было видно цвет фона (белый,серый)
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor) // Maintain a square aspect ratio
        ])
        
        */

        slider.center = view.center
        slider.addTarget(self, action: #selector(sliderStateChanged), for: .valueChanged)
        view.addSubview(slider)
    }

    
    @objc func sliderStateChanged() {
        let sliderValue = slider.value
        
        if sliderValue > 0.5 {
            if !isDarkMode {
                setDarkMode()
            }
        } else {
            if isDarkMode {
                setLightMode()
            }
        }

        saveSettings()
    }

    func setLightMode() {
        UIView.transition(with: imageView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.view.backgroundColor = .white
            self.imageView.image = self.lightImage
        }, completion: nil)
        
        isDarkMode = false
    }

    func setDarkMode() {
        UIView.transition(with: imageView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.view.backgroundColor = .black
            self.imageView.image = self.darkImage
        }, completion: nil)
        
        isDarkMode = true
    }

    func saveSettings() {
        let defaults = UserDefaults.standard
        let sliderValue = slider.value
        defaults.set(sliderValue > 0.5, forKey: "sliderState")
        defaults.set(isDarkMode, forKey: "darkMode")
    }

    func loadSettings() {
        let defaults = UserDefaults.standard
        let sliderState = defaults.bool(forKey: "sliderState")
        let darkMode = defaults.bool(forKey: "darkMode")

        slider.value = sliderState ? 1.0 : 0.0

        if darkMode {
            setDarkMode()
        } else {
            setLightMode()
        }
    }
}




