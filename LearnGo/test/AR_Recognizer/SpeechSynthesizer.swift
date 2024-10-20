//
//  SpeechSynthesizer.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/19.
//

import Foundation
import AVFoundation

class SpeechSynthesizer {
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String, language: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        synthesizer.speak(utterance)
    }
}
