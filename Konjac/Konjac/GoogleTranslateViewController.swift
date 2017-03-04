//
//  GoogleTranslateViewController.swift
//  Konjac
//
//  Created by Yoshitaka Seki on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import UIKit

final class GoogleTranslateViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var destinationTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!

    @IBAction func saveDidTap(_ sender: UIBarButtonItem) {
        print("action!", sourceTextView.text, destinationTextView.text)
    }
    @IBAction func viewDidTap(_ sender: Any) {
    }
    @IBAction func translateButtonDidTap(_ sender: Any) {
    }
}
