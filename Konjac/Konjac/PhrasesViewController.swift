//
//  PhrasesViewController.swift
//  Konjac
//
//  Created by 高松幸平 on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import UIKit

class PhrasesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PhraseTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedRow = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: selectedRow, animated: true)
        }
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

extension PhrasesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "RikoModalViewStoryboard", bundle: Bundle.main)
        let riko = storyboard.instantiateInitialViewController() as! RikoModalViewController

        // FIXME: use real data!
        riko.engPhrase = "asta la vista babies"
        riko.jpnPhrase = "さよならだぜベイビ"
        
        let rootViewController = UIApplication.shared.delegate?.window!?.rootViewController
        rootViewController!.modalPresentationStyle = UIModalPresentationStyle.currentContext
        present(riko, animated: true)
    }
}

extension PhrasesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PhraseTableViewCell
        return cell
    }
}
