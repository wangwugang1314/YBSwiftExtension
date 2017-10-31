//
//  UISliderExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS)
import UIKit


// MARK: - Methods
public extension UISlider {
	
	/// 设置滑块数值
	///
	/// - Parameters:
	///   - value: 需要设置的数值
	///   - animated: 是否需要动画
	///   - duration: 动画时间(默认1秒)
	///   - completion: 完成回调
	public func yb_setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.setValue(value, animated: true)
			}, completion: { finished in
				completion?()
			})
		} else {
			setValue(value, animated: false)
			completion?()
		}
	}
	
}
#endif
