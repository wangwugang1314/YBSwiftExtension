//
//  IntExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//


import UIKit


// MARK: - Properties
public extension Int {
	
	/// 绝对值
	public var yb_abs: Int {
		return Swift.abs(self)
	}
	
	/// 带有当前地区货币的字符串
	public var yb_asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as NSNumber)!
	}
	
	/// 返回一个0-当前数的范围
	public var yb_countableRange: CountableRange<Int> {
		return 0..<self
	}
	
	/// 返回弧度
	public var  yb_degreesToRadians: Double {
		return Double.pi * Double(self) / 180.0
	}
	
	/// 返回当前数的整数值的数组
	public var yb_digits: [Int] {
		var digits: [Int] = []
		for char in String(self).characters {
			if let int = Int(String(char)) {
				digits.append(int)
			}
		}
		return digits
	}
	
	/// 返回当前数值的长度
	public var yb_digitsCount: Int {
		return String(self).characters.count
	}
	
	/// 整数检查是否是
	public var yb_isEven: Bool {
		return (self % 2) == 0
	}
	
	/// 检查是否是基数
	public var yb_isOdd: Bool {
		return (self % 2) != 0
	}
	
	/// 检查是否是正数
	public var yb_isPositive: Bool {
		return self > 0
	}
	
	/// 检查是否是负数
	public var yb_isNegative: Bool {
		return self < 0
	}
	
	/// 转化为UInt
	public var yb_uInt: UInt {
		return UInt(self)
	}
	
	/// 转化为Double.
	public var yb_double: Double {
		return Double(self)
	}
	
	/// 转化为Float.
	public var yb_float: Float {
		return Float(self)
	}
	
	/// 转化为CGFloat.
	public var yb_cgFloat: CGFloat {
		return CGFloat(self)
	}
	
	/// 转化为String.
	public var yb_string: String {
		return String(self)
	}
	
	/// 转化为度数
	public var yb_radiansToDegrees: Double {
		return Double(self) * 180 / Double.pi
	}
	
	/// 返回罗马字符串
	public var yb_romanNumeral: String? {
		// https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
		guard self > 0 else { // there is no roman numerals for 0 or negative numbers
			return nil
		}
		let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
		let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
		
		var romanValue = ""
		var startingValue = self
		
		for (index, romanChar) in romanValues.enumerated() {
			let arabicValue = arabicValues[index]
			let div = startingValue / arabicValue
			if (div > 0) {
				for _ in 0..<div {
					romanValue += romanChar
				}
				startingValue -= arabicValue * div
			}
		}
		return romanValue
	}
	
	/// 以秒数为单位的字符串
	public var yb_timeString: String {
		guard self > 0 else {
			return "0 sec"
		}
		if self < 60 {
			return "\(self) sec"
		}
		if self < 3600 {
			return "\(self / 60) min"
		}
		let hours = self / 3600
		let mins = (self % 3600) / 60
		
		if hours != 0 && mins == 0 {
			return "\(hours)h"
		}
		return "\(hours)h \(mins)m"
	}
	
	/// SwifterSwift: String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
	public var yb_kFormatted: String {
		var sign: String {
			return self >= 0 ? "" : "-"
		}
		let abs = self.yb_abs
		if abs == 0 {
			return "0k"
		} else if abs >= 0 && abs < 1000 {
			return "0k"
		} else if abs >= 1000 && abs < 1000000 {
			return String(format: "\(sign)%ik", abs / 1000)
		}
		return String(format: "\(sign)%ikk", abs / 100000)
	}
	
}


// MARK: - Methods
public extension Int {
	
	/// 返回自己和N的最大公约数
	public func yb_gcd(of n: Int) -> Int {
		return n == 0 ? self : n.yb_gcd(of: self % n)
	}
	
	/// 返回自己和N的最小公倍数
	public func yb_lcm(of n: Int) -> Int {
		return (self * n).yb_abs / yb_gcd(of: n)
	}
	
	/// 返回之间的任意数
	public static func yb_random(between min: Int, and max: Int) -> Int {
		return yb_random(inRange: min...max)
	}
	
	/// 返回一个闭区间的随机数
	public static func yb_random(inRange range: ClosedRange<Int>) -> Int {
		let delta = UInt32(range.upperBound - range.lowerBound + 1)
		return range.lowerBound + Int(arc4random_uniform(delta))
	}
	
}


// MARK: - Initializers
public extension Int {
	
	/// 返回一个随机数
	public init(randomBetween min: Int, and max: Int) {
		self = Int.yb_random(between: min, and: max)
	}
	
	/// 返回一个区间的随机数
	public init(randomInRange range: ClosedRange<Int>) {
		self = Int.yb_random(inRange: range)
	}
	
}


// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base integer.
///   - rhs: exponent integer.
/// - Returns: exponentiation result (example: 2 ** 3 = 8).
public func ** (lhs: Int, rhs: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return pow(Double(lhs), Double(rhs))
}

prefix operator √
/// SwifterSwift: Square root of integer.
///
/// - Parameter int: integer value to find square root for
/// - Returns: square root of given integer.
public prefix func √ (int: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(Double(int))
}

infix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: integer number.
///   - rhs: integer number.
/// - Returns: tuple of plus-minus operation (example: 2 ± 3 -> (5, -1)).
public func ± (lhs: Int, rhs: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return (lhs + rhs, lhs - rhs)
}

prefix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameter int: integer number
/// - Returns: tuple of plus-minus operation (example: ± 2 -> (2, -2)).
public prefix func ± (int: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return 0 ± int
}
