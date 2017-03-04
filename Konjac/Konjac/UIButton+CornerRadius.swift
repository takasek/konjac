//
//  UIButton+CornerRadius.swift
//  avsynthTest
//
//  Created by 高松幸平 on 2017/03/04.
//  Copyright © 2017年 高松幸平. All rights reserved.
//

import UIKit

extension UIButton {
    func setCornerRadius(with radius: CGFloat) {
        self.layer.cornerRadius = radius;
        self.clipsToBounds = true;
    }
}
