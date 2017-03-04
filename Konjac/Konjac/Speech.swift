//
//  Speech.swift
//  Konjac
//
//  Created by jeffruberg on 3/4/17.
//  Copyright © 2017 trySwiftHackathon. All rights reserved.
//

import Foundation
import AVFoundation

class Speech: NSObject, AVSpeechSynthesizerDelegate {
    let synthesizer: AVSpeechSynthesizer
    var active: Bool
    var enabled: Bool { return !active }

    override init() {
        self.synthesizer = AVSpeechSynthesizer()
        self.active = false

        super.init()

        self.synthesizer.delegate = self
    }

    func speak(text: String) {
        if active { return }
        let utter = AVSpeechUtterance(string: text)
        self.synthesizer.speak(utter)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        active = true
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        active = true
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        active = false
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        active = false
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        active = false
    }
}
