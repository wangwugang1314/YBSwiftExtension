//
//  UITextViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - Methods
public extension UITextView {
	
	/// 清除文字
	public func yb_clear() {
		text = ""
		attributedText = NSAttributedString(string: "")
	}
	
	/// 滚动到底部
	public func yb_scrollToBottom() {
		let range = NSMakeRange((text as NSString).length - 1, 1)
		scrollRangeToVisible(range)
	}
	
	/// 滚动到顶部
	public func yb_scrollToTop() {
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}
	
}
#endif
