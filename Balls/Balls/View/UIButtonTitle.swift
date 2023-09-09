//
//  UIButtonTitle.swift
//  Balls
//
//  Created by OneClick on 8/9/23.
//

import UIKit

extension UIButton {
    func updateConfettiButtonTitle(isConfettiEnabled: Bool) {
        if isConfettiEnabled {
            setTitle("🎉", for: .normal)
        } else {
            setTitle("🎉", for: .normal) // Update with the appropriate title for the disabled state.
        }
    }

    func updateMusicButtonTitle(isPlaying: Bool) {
        if isPlaying {
            setTitle("🔔", for: .normal) // Playing
        } else {
            setTitle("🔕", for: .normal) // Paused
        }
    }
}

