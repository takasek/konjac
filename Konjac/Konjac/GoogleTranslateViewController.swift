//
//  GoogleTranslateViewController.swift
//  Konjac
//
//  Created by Yoshitaka Seki on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import UIKit
import SwiftyJSON

final class GoogleTranslateViewController: UIViewController {

    @IBOutlet weak var sourceTextView: UITextView!  {
        didSet {
            sourceTextView.text = ""
        }
    }
    @IBOutlet weak var destinationTextView: UITextView! {
        didSet {
            destinationTextView.text = ""
        }
    }
    @IBOutlet weak var translateButton: UIButton! {
        didSet {
            translateButton.setCornerRadius(with: 20)
        }
    }

    private let tranlsater = GoogleTranslater()

    @IBAction func saveDidTap(_ sender: UIBarButtonItem) {
        print("action!", sourceTextView.text, destinationTextView.text)
    }
    @IBAction func viewDidTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func translateButtonDidTap(_ sender: Any) {
        view.endEditing(true)

        if let source = sourceTextView.text {
            tranlsater.tranlate(source: source) { [weak self] (result) in
                self?.destinationTextView.text = result
            }
        }
    }
}
