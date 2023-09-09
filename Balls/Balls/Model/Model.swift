import UIKit
import AVFoundation

class GameModel {
    var circles: [UIView] = []
    var audioPlayer: AVAudioPlayer?
    var explosionAudioPlayer: AVAudioPlayer?
    var isConfettiEnabled = false
    var isPictureVisible = false
   // var circleImageNames: [String] = ["red_circle", "green_circle", "blue_circle", "yellow_circle", "orange_circle"]
    var previousCircleColor: String?

    
    func setAudioParameters() {
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: Sounds().getAudioURL(resourse: "Color Clownies - Circus (320 kbps)", resourseType: "mp3"))
            audioPlayer?.numberOfLoops = -1 // количество циклов = -1 для бесконечного цикла
            audioPlayer?.prepareToPlay()
            
        } catch {
            print("Не удалось инициализировать аудиоплеер: \(error)")
        }
        
        do {
            
            explosionAudioPlayer = try AVAudioPlayer(contentsOf: Sounds().getAudioURL(resourse: "circle_explosion", resourseType: "mp3"))
            explosionAudioPlayer?.prepareToPlay()
            
        } catch {
            print("Не удалось инициализировать аудиоплеер: \(error)")
        }
        
    }

}



