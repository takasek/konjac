//
//  GoogleTranslater.swift
//  Konjac
//
//  Created by Yoshitaka Seki on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import Foundation

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
