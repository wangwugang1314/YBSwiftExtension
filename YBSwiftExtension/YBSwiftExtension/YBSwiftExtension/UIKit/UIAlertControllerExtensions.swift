//
//  UIAlertControllerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS)
import UIKit
import AudioToolbox


// MARK: - 方法
public extension UIAlertController {
	
	/// 在当前控制器中展现
	///
	/// - Parameters:
	///   - animated: 是否需要动画 (default is true).
	///   - vibrate: 震动 (default is false).
	///   - completion: 完成回调 (default is nil).
	public func yb_show(animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil) {
		UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
		if vibrate {
			AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
		}
	}
	
	/// Add an action to Alert
	///
	/// - Parameters:
	///   - title: 显示的标题action title
	///   - style: action style (default is UIAlertActionStyle.default)
	///   - isEnabled: 是否使能 (default is true)
	///   - handler: 按钮点击的时候的回调 (default is nil)
	/// - Returns: 返回一个创建好的 action
	@discardableResult public func yb_addAction(title: String, style: UIAlertActionStyle = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
		let action = UIAlertAction(title: title, style: style, handler: handler)
		action.isEnabled = isEnabled
		addAction(action)
		return action
	}
	
	/// Add a text field to Alert
	///
	/// - Parameters:
	///   - text: text field text (default is nil)
	///   - placeholder: text field placeholder text (default is nil)
	///   - editingChangedTarget: an optional target for text field's editingChanged
	///   - editingChangedSelector: an optional selector for text field's editingChanged
	public func yb_addTextField(text: String? = nil, placeholder: String? = nil, editingChangedTarget: Any?, editingChangedSelector: Selector?) {
		addTextField { tf in
			tf.text = text
			tf.placeholder = placeholder
			if let target = editingChangedTarget, let selector = editingChangedSelector {
				tf.addTarget(target, action: selector, for: .editingChanged)
			}
		}
	}
	
}


// MARK: - 构造方法
public extension UIAlertController {
	
	/// 创建一个新的弹窗，默认有OK的按钮
	///
	/// - Parameters:
	///   - title: 标题
	///   - message: 信息
	///   - defaultActionButtonTitle: 默认按钮标题 (default is "OK")
	///   - tintColor: 颜色 (default is nil)
	public convenience init(yb_title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
		self.init(title: yb_title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
		addAction(defaultAction)
		if let color = tintColor {
			view.tintColor = color
		}
	}
	
	/// 创建一个错误弹窗控制器，默认有一个错误按钮
	///
	/// - Parameters:
	///   - title: 弹窗控制器的标题 (default is "Error").
	///   - error: 错误信息
	///   - defaultActionButtonTitle: 默认按钮标题 (default is "OK")
	///   - tintColor: 弹窗颜色 (default is nil)
	public convenience init(yb_title: String = "Error", error: Error, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
		self.init(title: yb_title, message: error.localizedDescription, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
		addAction(defaultAction)
		if let color = tintColor {
			view.tintColor = color
		}
	}
	
}
#endif
