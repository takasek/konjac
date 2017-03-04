//
//  RikoModalViewController.swift
//  Konjac
//
//  Created by 高松幸平 on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import UIKit
import AVFoundation

class RikoModalViewController: UIViewController, AVSpeechSynthesizerDelegate {
    @IBOutlet weak var phraseLabel: UILabel!

    var phrase: String?

    lazy var speaker = Speaker()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.6)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let s = self.phrase else { return }
        self.speaker.speak(str: s, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTap(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func stopTap(_ sender: Any) {
        self.speaker.stop()
    }
    @IBAction func pauseResume(_ sender: Any) {
        self.speaker.pauseResume()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.dismiss(animated: true, completion: nil)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        self.dismiss(animated: true, completion: nil)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        self.updatePauseResumeButton()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.updatePauseResumeButton()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        self.updatePauseResumeButton()
    }

    func updatePauseResumeButton() {
        // FIXME
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
