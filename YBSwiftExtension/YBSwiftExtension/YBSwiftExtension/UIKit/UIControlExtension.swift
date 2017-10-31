//
//  UIControlExtension.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/9/1.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit

extension UIControl {
    
    func add_touchUpInside(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    func add_valueChanged(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .valueChanged)
    }
    
    func add_touchDown(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchDown)
    }
    
    func add_touchDownRepeat(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchDownRepeat)
    }
    
    func add_touchDragInside(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchDragInside)
    }
    
    func add_touchDragOutside(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchDragOutside)
    }
    
    func add_touchDragEnter(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchDragEnter)
    }
    
    func add_touchDragExit(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchDragExit)
    }
    
    func add_touchUpOutside(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpOutside)
    }
    
    func add_touchCancel(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchCancel)
    }
}
