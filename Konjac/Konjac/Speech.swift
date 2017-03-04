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

class Speaker {
    let synthesizer: AVSpeechSynthesizer
    var speakRangeCompletion: ((NSRange?) -> Void)?

    init() {
        self.synthesizer = AVSpeechSynthesizer()
    }

    func speak(str: String, delegate: AVSpeechSynthesizerDelegate) {
        if self.synthesizer.isSpeaking { return }

        self.synthesizer.delegate = delegate

        self.synthesizer.speak(AVSpeechUtterance(string: str))
    }

    func pauseResume() {
        if self.synthesizer.isSpeaking && !self.synthesizer.isPaused {
            self.pause()
        } else {
            self.resume()
        }
    }

    private func pause() {
        self.synthesizer.pauseSpeaking(at: .immediate)
    }

    private func resume() {
        self.synthesizer.continueSpeaking()
    }

    func stop() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
}
