//
//  DataExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif


// MARK: - 属性
public extension Data {
	
	/// SwifterSwift: NSAttributedString from Data (if applicable).
	public var attributedString: NSAttributedString? {
		// http://stackoverflow.com/questions/39248092/nsattributedstring-extension-in-swift-3
		return try? NSAttributedString(data: self, options: [
			NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
			NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
	}
	
	/// 返回数组
	public var yb_bytes: [UInt8] {
		//http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
		return [UInt8](self)
	}
}

// MARK: - 方法
public extension Data {
	
	/// 使用指定编码转换成字符串(默认utf8)
	///
	/// - Parameter encoding: encoding.
	/// - Returns: String by encoding Data using the given encoding (if applicable).
	public func yb_string(encoding: String.Encoding = .utf8) -> String? {
		return String(data: self, encoding: encoding)
	}
	
}

// MARK: - 数据缓存
public extension Data {
    
    private static let yb_cacheFilePath = "YBCacheFilePath"
    
    static func yb_cachePath() -> String? {
        // 获取 Library 路径
        guard var path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last else {
            return nil
        }
        // 拼接 Caches + 自己的缓存路径
        path += "/Caches/"
        path += yb_cacheFilePath
        // 判断路径是否存在
        if !FileManager.default.fileExists(atPath: path) {
            // 路径中间如果有不存在的文件夹都会创建
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        return path
    }
    
    /// 保存数据
    ///
    /// - Parameter identifier: 标识符
    func yb_save(identifier: String) {
        guard let path = Data.yb_cachePath() else {
            print("数据保存失败")
            return
        }
        let filePath = path + "/\(identifier)"
        let url = URL(fileURLWithPath: filePath)
        guard let _ = try? write(to: url) else {
            print("数据保存失败")
            return
        }
        print("数据保存成功")
    }
    
    
    /// 获取数据
    ///
    /// - Parameter identifier: 标识符
    /// - Returns: 获取的数据
    static func yb_getData(identifier: String) -> Data? {
        guard let path = Data.yb_cachePath() else {
            return nil
        }
        let filePath = path + "/\(identifier)"
        let url = URL(fileURLWithPath: filePath)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
}

