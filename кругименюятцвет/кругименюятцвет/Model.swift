/* import UIKit
import AVFoundation

class GameModel {
    var circles: [UIView] = []
    var audioPlayer: AVAudioPlayer?
    var isConfettiEnabled = false
    var confettiViews: [UIView] = []
    var pictureImageView: UIImageView!
    var isPictureVisible = false

    init() {
        initializeAudioPlayer()
    }

    func initializeAudioPlayer() {
        if let audioPath = Bundle.main.path(forResource: "Color Clownies - Circus (320 kbps)", ofType: "mp3") {
            let audioURL = URL(fileURLWithPath: audioPath)

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
            } catch {
                print("Failed to initialize audio player: \(error)")
            }
        }
    }
}
*/
