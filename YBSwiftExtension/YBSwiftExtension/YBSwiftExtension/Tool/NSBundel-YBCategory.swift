//
//  NSBundel-YBCategory.swift
//  YBZhiWuDeng
//
//  Created by FuYun on 2016/11/26.
//  Copyright © 2016年 FuYun. All rights reserved.
//

import UIKit

extension Bundle {
    
    /// 加载XIB
    ///
    /// - Parameter name: 名称
    /// - Returns: 返回一个试图
    class func yb_loadNidView(name: String) -> UIView {
        let views = Bundle.main.loadNibNamed(name, owner: self, options: nil)
        return views!.last as! UIView
    }
}

extension NSArray {
    
    /// 加载本地plist文件（Bundel）
    ///
    /// - Parameter path: 文件名称(除了Bundel以外的路径)
    /// - Returns: 返回加载的文件
    static func yb_loadFile(path: String) -> NSArray? {
        let pathStr = Bundle.main.bundlePath + "/" + path
        return NSArray(contentsOfFile: pathStr)
    }
}

extension NSDictionary {
    
    /// 加载本地plist文件（Bundel）
    ///
    /// - Parameter path: 文件名称(除了Bundel以外的路径)
    /// - Returns: 返回加载的文件
    static func yb_loadFile(path: String) -> NSDictionary? {
        let pathStr = Bundle.main.bundlePath + "/" + path
        return NSDictionary(contentsOfFile: pathStr)
    }
}

extension NSData {
    
    /// 加载本地plist文件（Bundel）
    ///
    /// - Parameter path: 文件名称(除了Bundel以外的路径)
    /// - Returns: 返回加载的文件
    static func yb_loadFile(path: String) -> NSData? {
        let pathStr = Bundle.main.bundlePath + "/" + path
        return NSData(contentsOfFile: pathStr)
    }
}
