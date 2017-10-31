//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//


import UIKit


// MARK: - Properties
public extension String {
	
	/// base64解码 (if applicable).
	///
	///		"SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
	///
	public var yb_base64Decoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		guard let decodedData = Data(base64Encoded: self) else {
			return nil
		}
		return String(data: decodedData, encoding: .utf8)
	}
	
	/// base64编码 (if applicable).
	///
	///		"Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
	///
	public var yb_base64Encoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		let plainData = data(using: .utf8)
		return plainData?.base64EncodedString()
	}
	
	/// 返回字符数组
	///
	public var yb_charactersArray: [Character] {
		return Array(characters)
	}
	
	/// 将空格间隔转为驼峰
	///
	///		"sOme vAriable naMe".camelCased -> "someVariableName"
	///
	public var yb_camelCased: String {
		let source = lowercased()
		if source.characters.contains(" ") {
			let first = source.substring(to: source.index(after: source.startIndex))
			let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
			let camel = connected.replacingOccurrences(of: "\n", with: "")
			let rest = String(camel.characters.dropFirst())
			return first + rest
		}
		
		let first = source.lowercased().substring(to: source.index(after: source.startIndex))
		let rest = String(source.characters.dropFirst())
		return first + rest
	}
	
	/// 判断字符串是否包含Emoji
	///
	///		"Hello 😀".containEmoji -> true
	///
	public var yb_containEmoji: Bool {
		// http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
		for scalar in unicodeScalars {
			switch scalar.value {
			case 0x3030, 0x00AE, 0x00A9, // Special Characters
			0x1D000...0x1F77F, // Emoticons
			0x2100...0x27BF, // Misc symbols and Dingbats
			0xFE00...0xFE0F, // Variation Selectors
			0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
				return true
			default:
				continue
			}
		}
		return false
	}
	
	/// 获取字符串的第一个字符
	///
	///		"Hello".firstCharacterAsString -> Optional("H")
	///		"".firstCharacterAsString -> nil
	///
	public var yb_firstCharacterAsString: String? {
		guard let first = characters.first else {
			return nil
		}
		return String(first)
	}
	
	/// 判断字符串是否包含字母
	///
	///		"123abc".hasLetters -> true
	///		"123".hasLetters -> false
	///
	public var yb_hasLetters: Bool {
		return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
	}
	
	/// 判断字符串是否包含数字
	///
	///		"abcd".hasNumbers -> false
	///		"123abc".hasNumbers -> true
	///
	public var yb_hasNumbers: Bool {
		return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
	}
	
	/// 判断字符串是否只有字符
	///
	///		"abc".isAlphabetic -> true
	///		"123abc".isAlphabetic -> false
	///
	public var yb_isAlphabetic: Bool {
		let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
		let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
		return hasLetters && !hasNumbers
	}
	
	/// 检查字符串是否包含至少一个字母和一个数字。
	///
	///		// useful for passwords
	///		"123abc".isAlphaNumeric -> true
	///		"abc".isAlphaNumeric -> false
	///
	public var yb_isAlphaNumeric: Bool {
		let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
		let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
		let comps = components(separatedBy: .alphanumerics)
		return comps.joined(separator: "").characters.count == 0 && hasLetters && hasNumbers
	}
	
	/// 判断字符串是否是有效的邮箱
	///
	///		"john@doe.com".isEmail -> true
	///
	public var yb_isEmail: Bool {
		// http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
		return yb_matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
	}
	
	/// 判断字符串是否是有效的URL
	///
	///		"https://google.com".isValidUrl -> true
	///
	public var yb_isValidUrl: Bool {
		return URL(string: self) != nil
	}
	
	/// 判断字符串是否是有效的URL（带请求头）
	///
	///		"https://google.com".isValidSchemedUrl -> true
	///		"google.com".isValidSchemedUrl -> false
	///
	public var yb_isValidSchemedUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme != nil
	}
	
	/// 判断字符串是否是有效的URL（Https）
	///
	///		"https://google.com".isValidHttpsUrl -> true
	///
	public var yb_isValidHttpsUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme == "https"
	}
	
	/// 检查字符串是否是一个有效的http URL。
	///
	///		"http://google.com".isValidHttpUrl -> true
	///
	public var yb_isValidHttpUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme == "http"
	}
	
	/// 检查字符串是否是一个有效的文件URL。
	///
	public var yb_isValidFileUrl: Bool {
		return URL(string: self)?.isFileURL ?? false
	}
	
	/// 检查字符串是否只包含数字。
	///
	///		"123".isNumeric -> true
	///		"abc".isNumeric -> false
	///
	public var yb_isNumeric: Bool {
		let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
		let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
		return  !hasLetters && hasNumbers
	}
	
	/// 获取最后一个字符
	///
	///		"Hello".lastCharacterAsString -> Optional("o")
	///		"".lastCharacterAsString -> nil
	///
	public var yb_lastCharacterAsString: String? {
		guard let last = characters.last else {
			return nil
		}
		return String(last)
	}
	
	/// 拉丁字母转化成英文
	///
	///		"Hèllö Wórld!".latinized -> "Hello World!"
	///
	public var yb_latinized: String {
		return folding(options: .diacriticInsensitive, locale: Locale.current)
	}
	
	/// 获取字符串长度
	///
	///		"Hello world!".length -> 12
	///
	public var yb_length: Int {
		return characters.count
	}
	
	/// 白字符串根据/n分离成数组
	///
	///		"Hello\ntest".lines -> ["Hello", "test"]
	///
	public var yb_lines: [String] {
		var result = [String]()
		enumerateLines { line, _ in
			result.append(line)
		}
		return result
	}
	
	/// 获取字符串中存在最多的字符
	///
	///		"This is a test, since e is appearing everywhere e should be the common character".mostCommonCharacter -> "e"
	///
	public var yb_mostCommonCharacter: String {
		let mostCommon = yb_withoutSpacesAndNewLines.characters.reduce([Character: Int]()) {
			var counts = $0
			counts[$1] = ($0[$1] ?? 0) + 1
			return counts
			}.max { $0.1 < $1.1 }?.0
		return mostCommon?.yb_string ?? ""
	}
	
	/// 翻转字符串
	///
	///		"foo".reversed -> "oof"
	///
	public var yb_reversed: String {
		return String(characters.reversed())
	}
	
	/// 返回Bool值
	///
	///		"1".bool -> true
	///		"False".bool -> false
	///		"Hello".bool = nil
	///
	public var yb_bool: Bool? {
		let selfLowercased = yb_trimmed.lowercased()
		if selfLowercased == "true" || selfLowercased == "1" {
			return true
		} else if selfLowercased == "false" || selfLowercased == "0" {
			return false
		}
		return nil
	}
    
    /// 根据日期格式将字符串转换成时间对象(默认的格式"yyyy-MM-dd")
    ///
    /// - Parameter f: 中间的格式默认是 -
    /// - Returns: 返回时间对象
    public func yb_date (f: String = "-") -> Date? {
        let selfLowercased = yb_trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy" + f + "MM" + f + "dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// 根据日期格式将字符串转换成时间对象(默认的格式"HH:mm:ss")
    ///
    /// - Parameter f: 中间的格式默认是 :
    /// - Returns: 返回时间对象
    public func yb_time (f: String = ":") -> Date? {
        let selfLowercased = yb_trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH" + f + "mm" + f + "ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// 根据日期格式将字符串转换成时间对象(默认的格式"yyyy-MM-dd HH:mm:ss")
    ///
    /// - Parameters:
    ///   - f_date: 日期间隔符号
    ///   - f_time: 时间间隔符号
    /// - Returns: 返回时间对象
    public func yb_dateTime (f_date: String = "-", f_time: String = ":") -> Date? {
		let selfLowercased = yb_trimmed.lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy" + f_date + "MM" + f_date + "dd HH" + f_time + "mm" + f_time + "ss"
		return formatter.date(from: selfLowercased)
	}
	
	/// 将字符串转化成Float类型
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional Float value from given string.
	public func yb_float(locale: Locale = .current) -> Float? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Float
	}
	
	/// 将字符串转化成double类型
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional Double value from given string.
	public func yb_double(locale: Locale = .current) -> Double? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Double
	}
	
	/// 将字符串转化成CGFloat类型
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional CGFloat value from given string.
	public func yb_cgFloat(locale: Locale = .current) -> CGFloat? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? CGFloat
	}
	
	/// 将字符串转化成Int类型
	///
	///		"101".int -> 101
	///
	public var yb_int: Int? {
		return Int(self)
	}
	
	/// 将字符串转化成URL
	///
	///		"https://google.com".url -> URL(string: "https://google.com")
	///		"not url".url -> nil
	///
	public var yb_url: URL? {
		return URL(string: self)
	}
	
	/// 删除前后的空格和换行
	///
	///		"   hello  \n".trimmed -> "hello"
	///
	public var yb_trimmed: String {
		return trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	/// 将字符串中的所有字符使用unicode的数组。
	///
	///		"SwifterSwift".unicodeArray -> [83, 119, 105, 102, 116, 101, 114, 83, 119, 105, 102, 116]
	///
	public var yb_unicodeArray: [Int] {
		return unicodeScalars.map({$0.hashValue})
	}
	
	/// 解析URL字符串来自URL字符串的可读字符串。
	///
	///		"it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
	///
	public var yb_urlDecoded: String {
		return removingPercentEncoding ?? self
	}
	
	/// URL编码
	///
	///		"it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
	///
	public var yb_urlEncoded: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}
	
	/// 清除所有的空格和换行
	///
	///		"   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
	///
	public var yb_withoutSpacesAndNewLines: String {
		return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
	}
	
	/// 返回字符串中所有单词的数组
	///
	///		"Swift is amazing".words -> ["Swift", "is", "amazing"]
	///
	public var yb_words: [String] {
		// https://stackoverflow.com/questions/42822838
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let comps = components(separatedBy: chararacterSet)
		return comps.filter { !$0.isEmpty }
	}
	
	/// 返回字符串中单词的个数
	///
	///		"Swift is amazing".wordsCount -> 3
	///
	public var yb_wordCount: Int {
		// https://stackoverflow.com/questions/42822838
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let comps = components(separatedBy: chararacterSet)
		let words = comps.filter { !$0.isEmpty }
		return words.count
	}
	
}


// MARK: - 方法
public extension String {
    
    /// 获取字符串所占的高度
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 宽度
    /// - Returns: 返回所占的高度
    public func yb_size(font: UIFont, width: CGFloat? = nil) -> CGSize {
        let attributes = [NSFontAttributeName: font]
        let bounds = (self as NSString).boundingRect(with: CGSize(width: width == nil ? CGFloat.greatestFiniteMagnitude : width!,
                                                                  height: CGFloat.greatestFiniteMagnitude),
                                                     options: [.usesLineFragmentOrigin],
                                                     attributes: attributes,
                                                     context: nil)
        return bounds.size
    }
    
    /// 获取字符串所占的高度
    ///
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - width: 宽度
    /// - Returns: 返回所占的高度
    public func yb_size(fontSize: CGFloat, width: CGFloat? = nil) -> CGSize {
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]
        let bounds = (self as NSString).boundingRect(with: CGSize(width: width == nil ? CGFloat.greatestFiniteMagnitude : width!,
                                                                  height: CGFloat.greatestFiniteMagnitude),
                                                     options: [.usesLineFragmentOrigin],
                                                     attributes: attributes,
                                                     context: nil)
        return bounds.size
    }
    
    /// 获取字符串所占的高度
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - attributes: 字符串索性
    /// - Returns: 返回所占的高度
    public func yb_getSize(width: CGFloat, attributes: [String: Any]) -> CGFloat {
        let bounds = (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                                     options: [.usesLineFragmentOrigin],
                                                     attributes: attributes,
                                                     context: nil)
        return bounds.size.height
    }
	
	/// 根据下表获取字符
	///
	///		"Hello World!"[3] -> "l"
	///		"Hello World!"[20] -> nil
	///
	/// - Parameter i: index.
	public subscript(safe i: Int) -> String? {
		guard i >= 0 && i < characters.count else {
			return nil
		}
		return String(self[index(startIndex, offsetBy: i)])
	}
	
	/// 根据半开区间获取子字符串
	///
	///		"Hello World!"[6..<11] -> "World"
	///		"Hello World!"[21..<110] -> nil
	///
	/// - Parameter range: Half-open range.
	public subscript(safe range: CountableRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) else {
			return nil
		}
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
			return nil
		}
		return self[lowerIndex..<upperIndex]
	}
	
	/// 根据开区间获取子字符串
	///
	///		"Hello World!"[6...11] -> "World!"
	///		"Hello World!"[21...110] -> nil
	///
	/// - Parameter range: Closed range.
	public subscript(safe range: ClosedRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) else {
			return nil
		}
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else {
			return nil
		}
		return self[lowerIndex..<upperIndex]
	}
	
	#if os(iOS) || os(macOS)
	/// 将字符串复制到全局的粘贴板
	///
	///		"SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
	///
	public func yb_copyToPasteboard() {
    #if os(iOS)
        UIPasteboard.general.string = self
    #elseif os(macOS)
        NSPasteboard.general().clearContents()
        NSPasteboard.general().setString(self, forType: NSPasteboardTypeString)
    #endif
	}
	#endif
	
	/// 转换成驼峰字符串
	///
	///		var str = "sOme vaRiabLe Name"
	///		str.camelize()
	///		print(str) // prints "someVariableName"
	///
	public mutating func yb_camelize() {
		self = yb_camelCased
	}
	
	/// 判断字符串是否只包含唯一的字符
	///
	public func yb_hasUniqueCharacters() -> Bool {
		guard self.characters.count > 0 else { return false }
		var uniqueChars = Set<String>()
		for char in self.characters {
			if uniqueChars.contains(String(char)) {
				return false
			}
			uniqueChars.insert(String(char))
		}
		return true
	}
	
	/// 判断字符串是否包含某个子字符串
	///
	///		"Hello World!".contain("O") -> false
	///		"Hello World!".contain("o", caseSensitive: false) -> true
	///
	/// - Parameters:
	///   - string: 需要查找的子字符串
	///   - caseSensitive: 是否区分大小写 (default is true).
	/// - Returns: true if string contains one or more instance of substring.
	public func yb_contains(_ string: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return range(of: string, options: .caseInsensitive) != nil
		}
		return range(of: string) != nil
	}
	
	/// 获取去包含的子字符串个数
	///
	///		"Hello World!".count(of: "o") -> 2
	///		"Hello World!".count(of: "L", caseSensitive: false) -> 3
	///
	/// - Parameters:
	///   - string: 需要查找的子字符串
	///   - caseSensitive: 是否区分大小写 (default is true).
	/// - Returns: count of appearance of substring in string.
	public func yb_count(of string: String, caseSensitive: Bool = true) -> Int {
		if !caseSensitive {
			return lowercased().components(separatedBy: string.lowercased()).count - 1
		}
		return components(separatedBy: string).count - 1
	}
	
	/// 判断是否已自定字符串结尾
	///
	///		"Hello World!".ends(with: "!") -> true
	///		"Hello World!".ends(with: "WoRld!", caseSensitive: false) -> true
	///
	/// - Parameters:
	///   - suffix: 需要查找的子字符串
	///   - caseSensitive: 是否区分大小写 (default is true).
	/// - Returns: true if string ends with substring.
	public func yb_ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return lowercased().hasSuffix(suffix.lowercased())
		}
		return hasSuffix(suffix)
	}
	
	/// 查找第一个相同字符串的索引
	///
	///		"Hello World!".firstIndex(of: "l") -> 2
	///		"Hello World!".firstIndex(of: "s") -> nil
	///
	/// - Parameter string: 需要查找的子字符串
	/// - Returns: 返回子字符串的第一个索引 (if applicable).
	public func yb_firstIndex(of string: String) -> Int? {
		return Array(characters).map({String($0)}).index(of: string)
	}
	
	/// 拉丁化的字符串。
	///
	///		var str = "Hèllö Wórld!"
	///		str.latinize()
	///		print(str) // prints "Hello World!"
	///
	public mutating func yb_latinize() {
		self = yb_latinized
	}
	
	/// 获取指定长度的随机字符串
	///
	///		String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
	///
	/// - Parameter length: number of characters in string.
	/// - Returns: random string of given length.
	public static func yb_random(ofLength length: Int) -> String {
		guard length > 0 else { return "" }
		let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		return (0..<length).reduce("") {
			let randomIndex = arc4random_uniform(UInt32(base.characters.count))
			let randomCharacter = "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
			return $0.0 + randomCharacter
		}
	}
	
	/// 翻转字符串
	public mutating func yb_reverse() {
		self = String(characters.reversed())
	}
	
	/// 获取子字符串(根据位置)
	///
	///		"Hello World".slicing(from: 6, length: 5) -> "World"
	///
	/// - Parameters:
	///   - i: string index the slicing should start from.
	///   - length: amount of characters to be sliced after given index.
	/// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World")
	public func yb_subString(from i: Int, length: Int) -> String? {
		guard length >= 0, i >= 0, i < characters.count  else {
			return nil
		}
		guard i.advanced(by: length) <= characters.count else {
			return yb_subString(at: i)
		}
		guard length > 0 else {
			return ""
		}
		return self[safe: i..<i.advanced(by: length)]
	}
	
	/// 获取子字符串（会替换）(根据位置)
	///
	///		var str = "Hello World"
	///		str.slice(from: 6, length: 5)
	///		print(str) // prints "World"
	///
	/// - Parameters:
	///   - i: string index the slicing should start from.
	///   - length: amount of characters to be sliced after given index.
	public mutating func yb_subStr(from i: Int, length: Int) {
		if let str = yb_subString(from: i, length: length) {
			self = str
		}
	}
	
	/// 获取子字符串
	///
	///		"Hello World".slicing(from: 6, to: 11) -> "World"
	///
	/// - Parameters:
	///   - start: string index the slicing should start from.
	///   - end: string index the slicing should end at.
	/// - Returns: sliced substring starting from start index, and ends at end index (if applicable) (example: "Hello World".slicing(from: 6, to: 11) -> "World")
	public func yb_subString(from start: Int, to end: Int) -> String? {
		guard end >= start else {
			return nil
		}
		return self[safe: start..<end]
	}
	
	/// 获取子字符串（会替换）(根据位置)
	///
	///		var str = "Hello World"
	///		str.slice(from: 6, to: 11)
	///		print(str) // prints "World"
	///
	/// - Parameters:
	///   - start: string index the slicing should start from.
	///   - end: string index the slicing should end at.
	public mutating func yb_subStr(from start: Int, to end: Int) {
		if let str = yb_subString(from: start, to: end) {
			self = str
		}
	}
	
	/// 从指定位置到结尾（不会替换）
	///
	///		"Hello World".slicing(at: 6) -> "World"
	///
	/// - Parameter i: string index the slicing should start from.
	/// - Returns: sliced substring starting from start index (if applicable) (example: "Hello world".slicing(at: 6) -> "world")
	public func yb_subString(at i: Int) -> String? {
		guard i < characters.count else {
			return nil
		}
		return self[safe: i..<characters.count]
	}
	
	/// 从指定位置到结尾（会替换）
	///
	///		var str = "Hello World"
	///		str.slice(at: 6)
	///		print(str) // prints "World"
	///
	/// - Parameter i: string index the slicing should start from.
	public mutating func yb_subStr(at i: Int) {
		if let str = yb_subString(at: i) {
			self = str
		}
	}
	
	/// 根据指定字符分割字符串成数组
	///
	///		"hello World".splited(by: " ") -> ["hello", "World"]
	///
	/// - Parameter separator: separator to split string by.
	/// - Returns: array of strings separated by given string.
	public func yb_splitted(by separator: Character) -> [String] {
		return characters.split{$0 == separator}.map(String.init)
	}
	
	/// 判断字符串是否已指定字符串开始
	///
	///		"hello World".starts(with: "h") -> true
	///		"hello World".starts(with: "H", caseSensitive: false) -> true
	///
	/// - Parameters:
	///   - suffix: substring to search if string starts with.
	///   - caseSensitive: 是否区分大小写 (default is true).
	/// - Returns: true if string starts with substring.
	public func yb_starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return lowercased().hasPrefix(prefix.lowercased())
		}
		return hasPrefix(prefix)
	}
	
	/// 通过指定格式将字符串转化成事件对象
	///
	///		"2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
	///		"not date string".date(withFormat: "yyyy-MM-dd") -> nil
	///
	/// - Parameter format: date format.
	/// - Returns: Date object from string (if applicable).
	public func yb_date(withFormat format: String) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.date(from: self)
	}
	
	/// 删除字符串前后的空格和换行
	///
	///		var str = "  \n Hello World \n\n\n"
	///		str.trim()
	///		print(str) // prints "Hello World"
	///
	public mutating func yb_trim() {
		self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	/// 从指定的位置截断字符串（替换原有的字符串）
	///
	///		var str = "This is a very long sentence"
	///		str.truncate(toLength: 14)
	///		print(str) // prints "This is a very..."
	///
	/// - Parameters:
	///   - toLength: maximum number of characters before cutting.
	///   - trailing: string to add at the end of truncated string (default is "...").
	public mutating func yb_truncate(toLength: Int, trailing: String? = "...") {
		guard toLength > 0 else {
			return
		}
		if characters.count > toLength {
			self = substring(to: index(startIndex, offsetBy: toLength)) + (trailing ?? "")
		}
	}
	
	/// 从指定的位置截断字符串（返回新的字符串）
	///
	///		"This is a very long sentence".truncated(toLength: 14) -> "This is a very..."
	///		"Short sentence".truncated(toLength: 14) -> "Short sentence"
	///
	/// - Parameters:
	///   - toLength: maximum number of characters before cutting.
	///   - trailing: string to add at the end of truncated string.
	/// - Returns: truncated string (this is an extr...).
	public func yb_truncated(toLength: Int, trailing: String? = "...") -> String {
		guard 1..<characters.count ~= toLength else { return self }
		return substring(to: index(startIndex, offsetBy: toLength)) + (trailing ?? "")
	}
	
	/// URL解码
	///
	///		var str = "it's%20easy%20to%20decode%20strings"
	///		str.urlDecode()
	///		print(str) // prints "it's easy to decode strings"
	///
	public mutating func yb_urlDecode() {
		if let decoded = removingPercentEncoding {
			self = decoded
		}
	}
	
	/// 编码URL
	///
	///		var str = "it's easy to encode strings"
	///		str.urlEncode()
	///		print(str) // prints "it's%20easy%20to%20encode%20strings"
	///
	public mutating func yb_urlEncode() {
		if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
			self = encoded
		}
	}
	
	/// 验证字符串是否匹配正则
	///
	/// - Parameter pattern: Pattern to verify.
	/// - Returns: true if string matches the pattern.
	func yb_matches(pattern: String) -> Bool {
		return range(of: pattern,
		             options: String.CompareOptions.regularExpression,
		             range: nil, locale: nil) != nil
	}
	
}


// MARK: - Operators
public extension String {
	
	/// 多次重复的字符串
	///
	///		'bar' * 3 -> "barbarbar"
	///
	/// - Parameters:
	///   - lhs: string to repeat.
	///   - rhs: number of times to repeat character.
	/// - Returns: new string with given string repeated n times.
	public static func * (lhs: String, rhs: Int) -> String {
		guard rhs > 0 else {
			return ""
		}
		return String(repeating: lhs, count: rhs)
	}
	
	/// 多次重复的字符串
	///
	///		3 * 'bar' -> "barbarbar"
	///
	/// - Parameters:
	///   - lhs: number of times to repeat character.
	///   - rhs: string to repeat.
	/// - Returns: new string with given string repeated n times.
	public static func * (lhs: Int, rhs: String) -> String {
		guard lhs > 0 else {
			return ""
		}
		return String(repeating: rhs, count: lhs)
	}
	
}


// MARK: - Initializers
public extension String {
	
	/// 创建一个新的base64字符串 (if applicable).
	///
	///		String(base64: "SGVsbG8gV29ybGQh") = "Hello World!"
	///		String(base64: "hello") = nil
	///
	/// - Parameter base64: base64 string.
	public init?(yb_base64: String) {
		guard let str = yb_base64.yb_base64Decoded else {
			return nil
		}
		self.init(str)
	}
	
	/// 根据指定长度创建一个任意的字符串
	///
	///		String(randomOfLength: 10) -> "gY8r3MHvlQ"
	///
	/// - Parameter length: number of characters in string.
	public init(yb_randomOfLength length: Int) {
		self = String.yb_random(ofLength: length)
	}
	
}


// MARK: - 属性字符串扩展
public extension String {

	/// 黑体（粗）
	public var yb_bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
	}
	
	/// 凸显的字符串
	public var yb_underline: NSAttributedString {
		return NSAttributedString(string: self, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
	}
	
	/// 删除线的字符串。
	public var yb_strikethrough: NSAttributedString {
		return NSAttributedString(string: self, attributes: [NSStrikethroughStyleAttributeName: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
	}
	
	/// 斜体的字符串。
	public var yb_italic: NSAttributedString {
	return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
}


//MARK: - NSString extensions
public extension String {
	
	/// string -> NSString
	public var yb_nsString: NSString {
		return NSString(string: self)
	}
	
	/// 最后的路径组件
	public var yb_lastPathComponent: String {
		return (self as NSString).lastPathComponent
	}
	
	/// 路径扩展
	public var yb_pathExtension: String {
		return (self as NSString).pathExtension
	}
	
	/// 删除最后一个路径
	public var yb_deletingLastPathComponent: String {
		return (self as NSString).deletingLastPathComponent
	}
	
	/// 删除路径扩展
	public var yb_deletingPathExtension: String {
		return (self as NSString).deletingPathExtension
	}
	
	/// 路径组件数组
	public var yb_pathComponents: [String] {
		return (self as NSString).pathComponents
	}
	
	/// 添加路径
	///
	/// - Parameter str: the path component to append to the receiver.
	/// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
	public func yb_appendingPathComponent(_ str: String) -> String {
		return (self as NSString).appendingPathComponent(str)
	}
	
	/// 添加路径
	///
	/// - Parameter str: The extension to append to the receiver.
	/// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
	public func yb_appendingPathExtension(_ str: String) -> String? {
		return (self as NSString).appendingPathExtension(str)
	}
	
}
