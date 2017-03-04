//
//  KonjacFirebase.swift
//  Konjac
//
//  Created by kfurue on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import Foundation

import Firebase
import GoogleSignIn

class KonjacFirebase: NSObject {
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    var ref: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    var msglength: NSNumber = 10
    fileprivate var _refHandle: FIRDatabaseHandle!
    var konjacHandler: (([KonjacModel]) -> Void)?
    var konjacSnaps: [KonjacModel] = []

    static let sharedInstance: KonjacFirebase = {
        let instance = KonjacFirebase()

        GIDSignIn.sharedInstance().signInSilently()
        instance.handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if user != nil {
                print("succeeded to login..")
            }
        }
        
        return instance
    }()

    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("phrases").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            
            guard let phrases = snapshot.value as? [String: String] else { return }

            var konjak = KonjacModel()
            konjak.question = phrases["question"]
            konjak.japanese = phrases["japanese"]
            konjak.english = phrases["english"]
            strongSelf.konjacSnaps.append(konjak)
            print(snapshot)
            strongSelf.konjacHandler?(strongSelf.konjacSnaps)
        })
    }

    func addObserveChanges(completion: (([KonjacModel]) -> Void)?) {
        completion?(konjacSnaps)
        self.konjacHandler = completion
    }
    
    func sendNewKonjac(newKonjac: KonjacModel) {
        var mdata = [String : String]()
        mdata["question"] = newKonjac.question
        mdata["japanese"] = newKonjac.japanese
        mdata["english"] = newKonjac.english

        self.ref.child("phrases").childByAutoId().setValue(mdata)
    }
}

struct KonjacModel {
    var question: String?
    var japanese: String?
    var english: String?
}
