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
    var attributedString: NSMutableAttributedString?
    var highlightColor: UIColor?

    override init() {
        self.synthesizer = AVSpeechSynthesizer()

        super.init()

        self.synthesizer.delegate = self
    }

    func resetAttributedString() {
        guard let attributedString = self.attributedString else { return }
        let newAttributedString = NSAttributedString(string: attributedString.string)
        attributedString.setAttributedString(newAttributedString)
    }

    // NOTE: this is just a hack while prototyping
    // ----- in the real app, everything should be setting the NSMutableAttributedString
    func speak(str: String) {
        self.speak(attrStr: NSMutableAttributedString(string: str), highlightColor: nil)
    }

    func speak(attrStr: NSMutableAttributedString, highlightColor: UIColor?) {
        if synthesizer.isSpeaking { return }

        self.highlightColor = highlightColor
        self.attributedString = attrStr

        let utter = AVSpeechUtterance(string: attrStr.string)
        self.synthesizer.speak(utter)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        self.resetAttributedString()
        if let c = self.highlightColor, let s = self.attributedString {
            s.addAttribute(NSForegroundColorAttributeName, value: c, range: characterRange)
        }
    }
}
