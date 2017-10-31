//
//  CharacterExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


// MARK: - Properties
public extension Character {
	
	/// 判断一个字符是否是 emoji
	///
	///		Character("😀").isEmoji -> true
	///
	public var yb_isEmoji: Bool {
		// http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
		let scalarValue = String(self).unicodeScalars.first!.value
		switch scalarValue {
		case 0x3030, 0x00AE, 0x00A9,// Special Characters
		0x1D000...0x1F77F, // Emoticons
		0x2100...0x27BF, // Misc symbols and Dingbats
		0xFE00...0xFE0F, // Variation Selectors
		0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
			return true
		default:
			return false
		}
	}
	
	/// 判断一个字符是否是数字
	///
	///		Character("1").isNumber -> true
	///		Character("a").isNumber -> false
	///
	public var yb_isNumber: Bool {
		return Int(String(self)) != nil
	}
	
    /// 判断一个字符是否是字母
	///
	///		Character("4").isLetter -> false
	///		Character("a").isLetter -> true
	///
    public var yb_isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
	/// 判断一个字符是否是大写
	///
	///		Character("a").isUppercased -> false
	///		Character("A").isUppercased -> true
	///
	public var yb_isUppercased: Bool {
		return String(self) == String(self).uppercased()
	}
	
	/// 判断一个字符是否是小写
	///
	///		Character("a").isLowercased -> true
	///		Character("A").isLowercased -> false
	///
	public var yb_isLowercased: Bool {
		return String(self) == String(self).lowercased()
	}
	
    /// 判断一个字符是否是空格
	///
	///		Character(" ").isWhiteSpace -> true
	///		Character("A").isWhiteSpace -> false
	///
    public var yb_isWhiteSpace: Bool {
        return String(self) == " "
    }
    
	/// 将字符转为整数
	///
	///		Character("1").int -> 1
	///		Character("A").int -> nil
	///
	public var yb_int: Int? {
		return Int(String(self))
	}
	
	/// 将字符转为字符串
	///
	///		Character("a").string -> "a"
	///
	public var yb_string: String {
		return String(self)
	}
	
    /// 返回小写字符
	///
	///		Character("A").lowercased -> Character("a")
	///
    public var yb_lowercased: Character {
        return String(self).lowercased().characters.first!
    }
    
    /// 返回大写字符
	///
	///		Character("a").uppercased -> Character("A")
	///
    public var yb_uppercased: Character {
        return String(self).uppercased().characters.first!
    }
    
}


// MARK: - Operators
public extension Character {
	
	/// 多次重复字符
	///
	///		Character("-") * 10 -> "----------"
	///
	/// - Parameters:
	///   - lhs: character to repeat.
	///   - rhs: number of times to repeat character.
	/// - Returns: string with character repeated n times.
	public static func * (lhs: Character, rhs: Int) -> String {
		guard rhs > 0 else {
			return ""
		}
		return String(repeating: String(lhs), count: rhs)
	}
	
	/// 多次重复字符
	///
	///		10 * Character("-") -> "----------"
	///
	/// - Parameters:
	///   - lhs: number of times to repeat character.
	///   - rhs: character to repeat.
	/// - Returns: string with character repeated n times.
	public static func * (lhs: Int, rhs: Character) -> String {
		guard lhs > 0 else {
			return ""
		}
		return String(repeating: String(rhs), count: lhs)
	}
	
}
