//
//  UIViewControllerExtensions.swift
//  SwifterSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - Properties
public extension UIViewController {
	
	/// 检查是否在屏幕上显示
	public var yb_isVisible: Bool {
		// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
		return self.isViewLoaded && view.window != nil
	}
	
	/// 获取navigationBar
	public var yb_navigationBar: UINavigationBar? {
		return navigationController?.navigationBar
	}
	
}

// MARK: - Methods
public extension UIViewController {
	
	/// 添加通知
	///
	/// - Parameters:
	///   - name: notification name.
	///   - selector: selector to run with notified.
	public func yb_addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}
	
	/// 移除通知
	///
	/// - Parameter name: notification name.
	public func yb_removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}
	
	/// 移除所有通知
	public func yb_removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}
	
}
#endif
