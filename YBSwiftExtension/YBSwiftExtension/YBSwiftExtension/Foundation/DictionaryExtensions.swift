//
//  DictionaryExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/24/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

// MARK: - Methods
public extension Dictionary {
	
	/// 检查键值是否存在
	///
	///		let dict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
	///		dict.has(key: "testKey") -> true
	///		dict.has(key: "anotherKey") -> false
	///
	/// - Parameter key: key to search for
	/// - Returns: true if key exists in dictionary.
	public func yb_has(key: Key) -> Bool {
		return index(forKey: key) != nil
	}
	
    /// 删除字典指定键值对数组
	///
	///		var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
	///		dict.removeAll(keys: ["key1", "key2"])
	///		dict.keys.contains("key3") -> true
	///		dict.keys.contains("key1") -> false
	///		dict.keys.contains("key2") -> false
	///
	/// - Parameter keys: keys to be removed
    public mutating func yb_removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
    
	/// 将字典转换成 json Data
	///
	/// - Parameter prettify: 是否美化
	/// - Returns: optional JSON Data (if applicable).
	public func yb_jsonData(prettify: Bool = false) -> Data? {
		guard JSONSerialization.isValidJSONObject(self) else {
			return nil
		}
		let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
		return try? JSONSerialization.data(withJSONObject: self, options: options)
	}
	
	/// 将字典转化成json字符串
	///
	///		dict.jsonString() -> "{"testKey":"testValue","testArrayKey":[1,2,3,4,5]}"
	///
	///		dict.jsonString(prettify: true)
	///		/*
	///		returns the following string:
	///
	///		"{
	///		"testKey" : "testValue",
	///		"testArrayKey" : [
	///			1,
	///			2,
	///			3,
	///			4,
	///			5
	///		]
	///		}"
	///
	///		*/
	///
	/// - Parameter prettify: 是否美化
	/// - Returns: optional JSON String (if applicable).
	public func yb_jsonString(prettify: Bool = false) -> String? {
		guard JSONSerialization.isValidJSONObject(self) else {
			return nil
		}
		let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
		let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options)
		return jsonData?.yb_string(encoding: .utf8)
	}
    
    /// 计算负荷的字典个数
	///
	/// - Parameter where: condition to evaluate each tuple entry against.
    /// - Returns: Count of entries that matches the where clousure.
    public func yb_count(where condition: @escaping ((key: Key, value: Value)) throws -> Bool ) rethrows -> Int {
        var count : Int = 0
        try self.forEach {
            if try condition($0) {
                count += 1
            }
        }
        return count
    }

}

// MARK: - 运行

public extension Dictionary {
    
    /// 合并两个字典的键值
	///
	///		let dict : [String : String] = ["key1" : "value1"]
	///		let dict2 : [String : String] = ["key2" : "value2"]
	///		let result = dict + dict2
	///		result["key1"] -> "value1"
	///		result["key2"] -> "value2"
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: An dictionary with keys and values from both.
    public static func +(yb_lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = yb_lhs
        rhs.forEach{ result[$0] = $1 }
        return result
    }
    
    // MARK: - Operators
    
    /// 将第二个字典的数据添加到第一个字典里面
	///
	///		var dict : [String : String] = ["key1" : "value1"]
	///		let dict2 : [String : String] = ["key2" : "value2"]
	///		dict += dict2
	///		dict["key1"] -> "value1"
	///		dict["key2"] -> "value2"
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    public static func +=(yb_lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach({ yb_lhs[$0] = $1})
    }
    
    
    /// 从字典中删除数组中包含的
	///
	///		let dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
	///		let result = dict-["key1", "key2"]
	///		result.keys.contains("key3") -> true
	///		result.keys.contains("key1") -> false
	///		result.keys.contains("key2") -> false
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    /// - Returns: a new dictionary with keys removed.
    public static func -(yb_lhs: [Key: Value], keys: [Key]) -> [Key: Value]{
        var result = yb_lhs
        result.yb_removeAll(keys: keys)
        return result
    }
    
    /// 从字典中删除数组中包含的
	///
	///		var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
	///		dict-=["key1", "key2"]
	///		dict.keys.contains("key3") -> true
	///		dict.keys.contains("key1") -> false
	///		dict.keys.contains("key2") -> false
	///
	/// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    public static func -=(lhs: inout [Key: Value], keys: [Key]) {
        lhs.yb_removeAll(keys: keys)
    }

}


// MARK: - Methods (ExpressibleByStringLiteral)
public extension Dictionary where Key: ExpressibleByStringLiteral {
	
	/// 将所有键值小写
	///
	///		var dict = ["tEstKeY": "value"]
	///		dict.lowercaseAllKeys()
	///		print(dict) // prints "["testkey": "value"]"
	///
	public mutating func yb_lowercaseAllKeys() {
		// http://stackoverflow.com/questions/33180028/extend-dictionary-where-key-is-of-type-string
		for key in keys {
			if let lowercaseKey = String(describing: key).lowercased() as? Key {
				self[lowercaseKey] = removeValue(forKey: key)
			}
		}
	}
	
}

