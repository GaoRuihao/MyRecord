//
//  NavigationController+addition.swift
//  MyRecord
//
//  Created by hao on 2018/10/18.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setTransparentNavigationBarStyle() {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
