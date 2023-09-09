//
//  Sounds.swift
//  кругименюятцвет
//
//  Created by Raman Kozar on 05/09/2023.
//

import Foundation

public class Sounds {
    
    // Method for getting audio URL
    //
    func getAudioURL(resourse: String, resourseType: String) -> URL {
        
        // настраивает аудиоплеер на воспроизведение файла из new group assets, музыка в цикле
        if let audioPath = Bundle.main.path(forResource: resourse, ofType: resourseType) {
            return URL(fileURLWithPath: audioPath)
        } else {
            return URL(fileURLWithPath: "")
        }
        
    }
    
}
