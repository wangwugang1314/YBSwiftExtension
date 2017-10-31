//
//  UINavigationBarExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - Methods
public extension UINavigationBar {
	
	/// 设置导航眼标题颜色字体大小
	///
	/// - Parameters:
	///   - font: 字体大小
	///   - color: 字体颜色 (default is .black).
	public func yb_setTitleFont(_ font: UIFont, color: UIColor = UIColor.black) {
		var attrs = [String: AnyObject]()
		attrs[NSFontAttributeName] = font
		attrs[NSForegroundColorAttributeName] = color
		titleTextAttributes = attrs
	}
	
	/// 是导航栏透明
	///
	/// - Parameter tint: 设置透明颜色 (default is .white).
	public func yb_makeTransparent(withTint tint: UIColor = .white) {
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
		isTranslucent = true
		tintColor = tint
		titleTextAttributes = [NSForegroundColorAttributeName: tint]
	}
	
	/// 设置导航栏背景颜色及文字颜色
	///
	/// - Parameters:
	///   - background: backgound color
	///   - text: text color
	public func yb_setColors(background: UIColor, text: UIColor) {
		isTranslucent = false
		backgroundColor = background
		barTintColor = background
		setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		tintColor = text
		titleTextAttributes = [NSForegroundColorAttributeName: text]
	}
}
#endif
