/* import UIKit

class GameView: UIViewController {
    var restartButton: UIButton!
    var musicButton: UIButton!
    var confettiButton: UIButton!

    func setupUI() {
     
            restartButton = UIButton(type: .custom)
            restartButton.setTitle("Restart", for: .normal)
            restartButton.setTitleColor(.white, for: .normal)
            restartButton.backgroundColor = UIColor.systemGreen
            restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
            restartButton.translatesAutoresizingMaskIntoConstraints = false

      
            musicButton = UIButton(type: .custom)
            musicButton.setTitle("🔔", for: .normal)
            musicButton.setTitleColor(.white, for: .normal)
            musicButton.backgroundColor = UIColor.systemBlue
            musicButton.addTarget(self, action: #selector(toggleMusic(_:)), for: .touchUpInside)
            musicButton.translatesAutoresizingMaskIntoConstraints = false

         
            confettiButton = UIButton(type: .custom)
            confettiButton.setTitle("🎉", for: .normal)
            confettiButton.setTitleColor(.white, for: .normal)
            confettiButton.backgroundColor = UIColor.systemOrange
            confettiButton.addTarget(self, action: #selector(toggleConfetti(_:)), for: .touchUpInside)
            confettiButton.translatesAutoresizingMaskIntoConstraints = false

  
            view.addSubview(restartButton)
            view.addSubview(musicButton)
            view.addSubview(confettiButton)

            NSLayoutConstraint.activate([
                restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                restartButton.widthAnchor.constraint(equalToConstant: 120),
                restartButton.heightAnchor.constraint(equalToConstant: 40),

                musicButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                musicButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                musicButton.widthAnchor.constraint(equalToConstant: 40),
                musicButton.heightAnchor.constraint(equalToConstant: 40),

                confettiButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                confettiButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                confettiButton.widthAnchor.constraint(equalToConstant: 40),
                confettiButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }


    func createPictureImageView() {

        pictureImageView = UIImageView()
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false

        let initialFrame = CGRect(x: 100, y: 100, width: 300, height: 300)
        pictureImageView.frame = initialFrame
        pictureImageView.image = UIImage(named: "picture")

      
        view.addSubview(pictureImageView)


        NSLayoutConstraint.activate([
            pictureImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pictureImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pictureImageView.widthAnchor.constraint(equalToConstant: 300),
            pictureImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }


    func setupBackgroundImage() {
     
        let backgroundImage = UIImage(named: "circus")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }


    func configureRestartButton() {
        restartButton.isHidden = true
        restartButton.layer.cornerRadius = 30
        restartButton.layer.shadowColor = UIColor.black.cgColor
        restartButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        restartButton.layer.shadowRadius = 10
        restartButton.layer.shadowOpacity = 0.5
        restartButton.layer.borderColor = UIColor.systemGreen.cgColor
        restartButton.layer.borderWidth = 2
        
      
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        

        startPulseAnimation()
    }


}
*/
