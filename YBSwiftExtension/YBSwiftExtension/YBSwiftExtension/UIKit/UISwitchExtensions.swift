//
//  UISwitchExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 08/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS)
import UIKit


// MARK: - Methods
public extension UISwitch {
	
	/// 转换选项
	///
	/// - Parameter animated: set true to animate the change (default is true)
	public func yb_toggle(animated: Bool = true) {
		setOn(!isOn, animated: animated)
	}
}
#endif
