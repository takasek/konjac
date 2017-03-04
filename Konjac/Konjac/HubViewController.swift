//
//  HubViewController.swift
//  avsynthTest
//
//  Created by 高松幸平 on 2017/03/04.
//  Copyright © 2017年 高松幸平. All rights reserved.
//

import UIKit

class HubViewController: UIViewController {
    @IBOutlet weak var transitToMainView: UIButton!
    @IBOutlet weak var transitToTranslate: UIButton!
    @IBOutlet weak var transitToSpeechTest: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        transitToMainView.setCornerRadius(with: 20)
        transitToTranslate.setCornerRadius(with: 20)
        transitToSpeechTest.setCornerRadius(with: 20)
    }
    
    @IBAction func transitTomainViewTap(_ sender: Any) {
        // implement codes to transit to mainview
        let viewController = storyboard?.instantiateViewController(withIdentifier: "PhrasesViewController")
        navigationController?.pushViewController(viewController!, animated: true)
    }

    @IBAction func transitToTranslateTap(_ sender: Any) {
        // implement codes to transit to translate
        print("i wanna go to transit view...")

        let vc = UIStoryboard(name: "GoogleTranslate", bundle: .main).instantiateInitialViewController()!
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func transitToSpeechTestTap(_ sender: Any) {
        // implement codes to transit to speech
        print("i wanna go to speech view...")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
