//
//  UIScreen+YBCategory.swift
//  YBZhiWuDeng
//
//  Created by FuYun on 2016/11/26.
//  Copyright © 2016年 FuYun. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /// 获取屏幕的昆都
    ///
    /// - Returns: 宽度
    class func width() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    
    /// 获取屏幕的高度
    ///
    /// - Returns: 高度值
    class func height() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    
    /// 获取屏幕的大小
    ///
    /// - Returns: 大小值
    class func size() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    
    /// 获取屏幕的bounds
    ///
    /// - Returns: bounds值
    class func bounds() -> CGRect {
        return UIScreen.main.bounds
    }
}

// MARK: - 屏幕等比(屏幕宽度默认是750像素)
extension Int {
    var screenScale: CGFloat {
        return CGFloat(self) / CGFloat(750.0) * UIScreen.width()
    }
}

extension Double {
    var screenScale: CGFloat {
        return CGFloat(self) / CGFloat(750.0) * UIScreen.width()
    }
}

extension CGFloat {
    var screenScale: CGFloat {
        return CGFloat(self) / CGFloat(750.0) * UIScreen.width()
    }
}

extension Float {
    var screenScale: CGFloat {
        return CGFloat(self) / CGFloat(750.0) * UIScreen.width()
    }
}
