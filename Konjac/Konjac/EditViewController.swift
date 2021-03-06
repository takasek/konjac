//
//  EditViewController.swift
//  Konjac
//
//  Created by 高松幸平 on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var japaneseTextView: UITextView!
    @IBOutlet weak var situationPicker: UIPickerView!
    
    let situations = ["なんか場所を聞かれた時", "技術系", "観光地系", "食べ物系", "文化風習系", "アニメ系"]

    var selectedSituation: String {
        let row = situationPicker.selectedRow(inComponent: 0)
        return situations[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTap(_ sender: Any) {
        KonjacFirebase.sharedInstance.sendNewKonjac(
            question: selectedSituation,
            japanese: japaneseTextView.text,
            english: englishTextView.text
        )
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    let translater = GoogleTranslater()
    @IBAction func didTapTranslate() {
        translater.tranlate(source: japaneseTextView.text ?? "", completion: { [weak self] in
            if let text = $0 {
                self?.englishTextView.text = $0
            }
        })
    }

    @IBAction func resign() {
        view.endEditing(true)
    }

}

extension EditViewController: UIPickerViewDelegate {
    
}

extension EditViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return situations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return situations[row]
    }
}
