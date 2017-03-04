//
//  HubViewController.swift
//  avsynthTest
//
//  Created by 高松幸平 on 2017/03/04.
//  Copyright © 2017年 高松幸平. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn

class HubViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var transitToMainView: UIButton!
    @IBOutlet weak var transitToTranslate: UIButton!
    @IBOutlet weak var transitToSpeechTest: UIButton!

    @IBOutlet weak var signInButton: GIDSignInButton!
    var handle: FIRAuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        transitToMainView.setCornerRadius(with: 20)
        transitToTranslate.setCornerRadius(with: 20)
        transitToSpeechTest.setCornerRadius(with: 20)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if user != nil {
                print("succeeded to signin")
            }
        }

    }
    
    @IBAction func transitTomainViewTap(_ sender: Any) {
        // implement codes to transit to mainview
        let viewController = storyboard?.instantiateViewController(withIdentifier: "PhrasesViewController")
        navigationController?.pushViewController(viewController!, animated: true)
    }

    @IBAction func transitToTranslateTap(_ sender: Any) {
        // implement codes to transit to translate
        print("i wanna go to transit view...")
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
