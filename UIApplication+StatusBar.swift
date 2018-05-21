//
//  UIApplication+StatusBar.swift
//  Studio
//
//  Created by Tong Tian on 2/4/18.
//  Copyright © 2018 Bizersoft. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
