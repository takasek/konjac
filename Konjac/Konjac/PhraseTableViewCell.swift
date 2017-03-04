//
//  PhrasesTableViewCell.swift
//  Konjac
//
//  Created by 高松幸平 on 2017/03/04.
//  Copyright © 2017年 trySwiftHackathon. All rights reserved.
//

import UIKit

class PhraseTableViewCell: UITableViewCell {
    @IBOutlet weak var mainPhrase: UILabel!
    @IBOutlet weak var subPhrase: UILabel!
    var speaker: Speaker?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected, let speaker = self.speaker, let text = self.mainPhrase.text {
            speaker.speak(str: text) { range in
                let mutableString = NSMutableAttributedString(string: text)
                if let r = range {
                    mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: r)
                }
                self.mainPhrase.attributedText = mutableString
            }
        }
    }
}
