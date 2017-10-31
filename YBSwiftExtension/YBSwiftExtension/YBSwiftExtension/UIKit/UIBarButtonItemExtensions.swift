//
//  UIBarButtonItemExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 08/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - Methods
public extension UIBarButtonItem {
	
	/// 添加事件
	///
	/// - Parameters:
	///   - target: 目标.
	///   - action: 方法.
	public func yb_addTarget(_ target: AnyObject, action: Selector) {
		self.target = target
		self.action = action
	}
	
}

extension UIBarButtonItem {
    
    /// 默认按钮大小
    private static let btnSize = CGSize(width: 50, height: 40)
    
    /// 自定义 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: 按钮文字
    ///   - fontSize: 字体大小 默认16
    ///   - color: 默认字体颜色
    ///   - higColor: 高亮字体颜色
    ///   - target: 点击事件对象
    ///   - action: 点击方法
    convenience init(title: String, fontSize: CGFloat = 16, color: UIColor, higColor: UIColor, target: Any?, action: Selector) {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        //        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(color, for: .normal)
        btn.setTitleColor(higColor, for: .highlighted)
        self.init(customView: btn)
    }
    
    
    /// 自定义 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - image: 默认图标
    ///   - higImage: 选中后的图标
    ///   - target: 点击事件对象
    ///   - action: 点击方法
    convenience init(image: String, higImage: String, target: Any?, action: Selector) {
        let btn = UIButton()
        btn.setImage(UIImage(named: image), for: .normal)
        btn.setImage(UIImage(named: higImage), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
    
    
    /// 自定义 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: 文字
    ///   - color: 默认文字颜色
    ///   - higColor: 高亮文字颜色
    ///   - image: 图片
    ///   - higImage: 高亮图片
    ///   - target: 按钮事件对象
    ///   - action: 按钮事件方法
    convenience init(title: String, color: UIColor, higColor: UIColor, image: String, higImage: String, target: Any?, action: Selector) {
        let btn = YBFrameButton(frame: CGRect(x: 0, y: 0, width: 60, height: 40),
                                imageFrame: CGRect(x: 0, y: 0, width: 20, height: 40),
                                textFrame: CGRect(x: 20, y: 0, width: 40, height: 40))
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(color, for: .normal)
        btn.setTitleColor(higColor, for: .highlighted)
        btn.setImage(UIImage(named: image), for: .normal)
        btn.setImage(UIImage(named: higImage), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}

