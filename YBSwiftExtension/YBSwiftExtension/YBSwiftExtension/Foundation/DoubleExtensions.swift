//
//  DoubleExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif


// MARK: - Properties
public extension Double {
	
	/// SwifterSwift: Int.
	public var int: Int {
		return Int(self)
	}
	
	/// SwifterSwift: Float.
	public var float: Float {
		return Float(self)
	}
	
	/// SwifterSwift: CGFloat.
	public var cgFloat: CGFloat {
		return CGFloat(self)
	}
    
    /// 保存指定位数小数
    ///
    /// - Parameter pointNum: 小数位的长度
    /// - Returns: 返回格式化的字符串
    func yb_format(pointNum: Int) -> String {
        return String(format: "%.\(pointNum)f", self)
    }
}


// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Double, rhs: Double) -> Double {
	// http://nshipster.com/swift-operators/
	return pow(lhs, rhs)
}

prefix operator √
/// SwifterSwift: Square root of double.
///
/// - Parameter double: double value to find square root for.
/// - Returns: square root of given double.
public prefix func √ (double: Double) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(double)
}
