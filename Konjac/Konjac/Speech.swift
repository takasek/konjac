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
    var attributedString: NSMutableAttributedString
    var active: Bool { didSet { self.didSetActive() } }
    var enabled: Bool { return !active }
    var highlightColor: UIColor?

    override init() {
        self.synthesizer = AVSpeechSynthesizer()
        self.active = false

        super.init()

        self.synthesizer.delegate = self
    }

    func didSetActive() {
        if !active {
            self.resetAttributedString()
        }
    }

    func resetAttributedString() {
        let newAttributedString = NSAttributedString(string: self.attributedString.string)
        self.attributedString.setAttributedString(newAttributedString)
    }

    // NOTE: this is just a hack while prototyping
    // ----- in the real app, everything should be setting the NSMutableAttributedString
    func speak(str: String) {
        self.speak(attrStr: NSMutableAttributedString(string: str), highlightColor: nil)
    }

    func speak(attrStr: NSMutableAttributedString, highlightColor: UIColor?) {
        if active { return }
        self.attributedString = attrStr
        let utter = AVSpeechUtterance(string: attrStr.string)
        self.synthesizer.speak(utter)
        self.highlightColor = highlightColor
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

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        self.resetAttributedString()
        if let c = self.highlightColor {
            self.attributedString.addAttribute(NSForegroundColorAttributeName, value: c, range: characterRange)
        }
    }
}
