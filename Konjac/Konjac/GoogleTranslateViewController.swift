//
//  GoogleTranslateViewController.swift
//  Konjac
//
//  Created by Yoshitaka Seki on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import UIKit
import SwiftyJSON

final class GoogleTranslater {
    var task: URLSessionDataTask?
    func tranlate(source: String, completion: @escaping (String?) -> Void) {

        let encodedSource = source.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        let urlString = "https://www.googleapis.com/language/translate/v2?key=AIzaSyBZomq_Mw-KA5UMteg7erVvyhYcYI1bkKw&target=en&q=\(encodedSource)"

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let jsonData = data,
                let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) {
                let result = JSON(json)["data"]["translations"][0]["translatedText"].string
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task?.resume()
    }
}

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
