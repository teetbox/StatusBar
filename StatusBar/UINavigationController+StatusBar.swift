//
//  UINavigationController+StatusBar.swift
//  StatusBar
//
//  Created by Matt Tian on 2018/5/21.
//  Copyright © 2018 TTSY. All rights reserved.
//

import UIKit

protocol PropertyStoring {
    associatedtype T
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T
}

extension PropertyStoring {
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
        guard let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
}

protocol ToggleProtocol {
    func toggle()
}

enum ToggleState {
    case on
    case off
}

extension UINavigationController: ToggleProtocol, PropertyStoring {
    
    typealias T = ToggleState
    
    private struct CustomProperties {
        static var toggleState = ToggleState.off
    }
    
    var toggleState: ToggleState {
        get {
            return getAssociatedObject(&CustomProperties.toggleState, defaultValue: CustomProperties.toggleState)
        }
        set {
            return objc_setAssociatedObject(self, &CustomProperties.toggleState, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func toggle() {
        toggleState = toggleState == .on ? .off : .on
        
        if toggleState == .on {
            // Shows background for status on
        } else {
            // Shows background for status off
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return toggleState == .off ? .default : .lightContent
    }
    
    func lightStatusBar() {
        if case .off = toggleState {
            toggle()
        }
    }
    
    func darkStatusBar() {
        if case .on = toggleState {
            toggle()
        }
    }
    
}
