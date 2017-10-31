//
//  UIDevice+Extension.swift
//  QQKongJianSwift
//
//  Created by MAC on 16/2/26.
//  Copyright © 2016年 MAC. All rights reserved.
//

import UIKit

extension UIDevice {
    
    /// 判断装置类型
    class func isIPhone_Swift() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? true : false
    }
    
    /// 是否是3.5
    class func isIPhone3_5_Swift() -> Bool {
        return UIScreen.main.bounds.height == 480.0
    }
    
    /// 是否是4
    class func isIPhone4_0_Swift() -> Bool {
        return UIScreen.main.bounds.height == 568.0
    }
    
    /// 是否是4.7
    class func isIPhone4_7_Swift() -> Bool {
        return UIScreen.main.bounds.height == 667.0
    }
    
    /// 是否是5.5
    class func isIPhone5_5_Swift() -> Bool {
        return UIScreen.main.bounds.height == 736.0
    }
    
    /// 版本等于(字符串比如 10.3.1)
    class func iOSVersionEqualTo(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version) == ComparisonResult.orderedSame
    }
    
    /// 版本大于(字符串比如 10.3.1)
    class func iOSVersionGreaterThan(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version) == ComparisonResult.orderedAscending
    }
    
    /// 版本大于等于(字符串比如 10.3.1)
    class func iOSVersionGreaterThanOrEqualTo(version: String) -> Bool {
        let com = UIDevice.current.systemVersion.compare(version)
        return com == ComparisonResult.orderedAscending || com == ComparisonResult.orderedSame
    }
    
    /// 版本小于(字符串比如 10.3.1)
    class func iOSVersionLessThan(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version) == ComparisonResult.orderedDescending
    }
    
    /// 版本小于等于(字符串比如 10.3.1)
    class func iOSVersionLessThanOrEqualTo(version: String) -> Bool {
        let com = UIDevice.current.systemVersion.compare(version)
        return com == ComparisonResult.orderedDescending || com == ComparisonResult.orderedSame
    }
    
    /// 本本是否大于等于iOS10
    class func iOSVersionGreaterThanOrEqualTo_iOS10() -> Bool {
        return iOSVersionGreaterThanOrEqualTo(version: "10.0.0")
    }
    
    /// 本本是否大于等于iOS9
    class func iOSVersionGreaterThanOrEqualTo_iOS9() -> Bool {
        return iOSVersionGreaterThanOrEqualTo(version: "9.0.0")
    }
}
