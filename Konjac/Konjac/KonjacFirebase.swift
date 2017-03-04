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

final class KonjacFirebase: NSObject {
    
    private var handle: FIRAuthStateDidChangeListenerHandle?
    private var ref: FIRDatabaseReference!
    private var messages: [FIRDataSnapshot] = []
    private var msglength: NSNumber = 10
    fileprivate var _refHandle: FIRDatabaseHandle!
    private var konjacHandler: (([KonjacModel]) -> Void)?
    var konjacSnaps: [KonjacModel] = []

    static let sharedInstance: KonjacFirebase = {
        let instance = KonjacFirebase()

        GIDSignIn.sharedInstance().signInSilently()
        instance.handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if user != nil {
                print("succeeded to login..")
                KonjacFirebase.sharedInstance.configureDatabase()
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
    
    func sendNewKonjac(question: String?, japanese: String?, english: String?) {
        var mdata = [String : String]()
        mdata["question"] = question
        mdata["japanese"] = japanese
        mdata["english"] = english

        self.ref.child("phrases").childByAutoId().setValue(mdata)
    }
}

struct KonjacModel {
    var question: String?
    var japanese: String?
    var english: String?
}
