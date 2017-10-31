//
//  WKWebView+YBExtension.swift
//  YBWebApp
//
//  Created by FuYun on 2016/12/30.
//  Copyright © 2016年 FuYun. All rights reserved.
//

import UIKit
import WebKit

extension WKWebView {
    
    // MARK: - 属性
    /// 加载本地Html
    /// - path 路径(只需要写文件的路径):
    /// - Returns: <#返回值#>
    func loadLocalHtml(path: String, isText: Bool = false){
        let str = Bundle.main.bundlePath
        let path = isText ? path : str + path
        var fileURL = URL(fileURLWithPath: path)
        if #available(iOS 9.0, *) {
            // iOS9 and above. One year later things are OK.
            loadFileURL(fileURL, allowingReadAccessTo: fileURL)
        } else {
            // iOS8. Things can (sometimes) be workaround-ed
            //   Brave people can do just this
            //   fileURL = try! pathForBuggyWKWebView8(fileURL: fileURL)
            //   webView.load(URLRequest(url: fileURL))
            do {
                fileURL = try fileURLForBuggyWKWebView8(fileURL: fileURL)
                load(URLRequest(url: fileURL))
            } catch let error as NSError {
                print("Error: " + error.debugDescription)
            }
        }
    }
    
    /// 拷贝本地Html
    /// - fileURL URL:
    /// - Returns: URL
    private func fileURLForBuggyWKWebView8(fileURL: URL) throws -> URL {
        // Some safety checks
        if !fileURL.isFileURL {
            throw NSError(
                domain: "BuggyWKWebViewDomain",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("URL must be a file URL.", comment:"")])
        }
        try! fileURL.checkResourceIsReachable()
        
        // Create "/temp/www" directory
        let fm = FileManager.default
        let tmpDirURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("www")
        try! fm.createDirectory(at: tmpDirURL, withIntermediateDirectories: true, attributes: nil)
        
        // Now copy given file to the temp directory
        let dstURL = tmpDirURL.appendingPathComponent(fileURL.lastPathComponent)
        let _ = try? fm.removeItem(at: dstURL)
        try! fm.copyItem(at: fileURL, to: dstURL)
        
        // Files in "/temp/www" load flawlesly :)
        return dstURL
    }
}
