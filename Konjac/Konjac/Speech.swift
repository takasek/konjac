//
//  Speech.swift
//  Konjac
//
//  Created by jeffruberg on 3/4/17.
//  Copyright © 2017 trySwiftHackathon. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Speaker: NSObject, AVSpeechSynthesizerDelegate {
    let synthesizer: AVSpeechSynthesizer
    var speakRangeCompletion: ((NSRange?) -> Void)?

    override init() {
        self.synthesizer = AVSpeechSynthesizer()

        super.init()

        self.synthesizer.delegate = self
    }

    func speak(str: String, onSpeakRange: @escaping (NSRange?) -> Void) {
        if self.synthesizer.isSpeaking { return }

        self.speakRangeCompletion = onSpeakRange

        self.synthesizer.speak(AVSpeechUtterance(string: str))
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        if let completion = self.speakRangeCompletion {
            completion(characterRange)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        if let completion = self.speakRangeCompletion {
            completion(nil)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if let completion = self.speakRangeCompletion {
            completion(nil)
        }
    }
}
