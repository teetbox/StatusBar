//
//  NextViewController.swift
//  StatusBar
//
//  Created by Matt Tian on 2018/5/21.
//  Copyright © 2018 TTSY. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.fromHEX(string: "#ABCDEF")
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(fromGesture:)))
        view.addGestureRecognizer(gesture)
        
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc func handleSwipe(fromGesture gesture: UISwipeGestureRecognizer) {
        // Only detected right swipe
        navigationController?.popViewController(animated: true)
    }
    
}
