//
//  YBColor+Category.swift
//  YBGongCheng
//
//  Created by FuYun on 16/8/5.
//  Copyright © 2016年 FuYun. All rights reserved.
//

import UIKit

// MARK: - 属性
extension UIColor {
    
    /// 获取RGB值
    public var yb_rgbComponenets: (red: Int, green: Int, blue: Int) {
        var red:	CGFloat = 0
        var green:	CGFloat = 0
        var blue:	CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0))
    }
    
    /// 获取透明度属性
    public var yb_alpha: CGFloat {
        var a: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    
    /// 16禁止字符串
    public var yb_hexString: String {
        var red:	CGFloat = 0
        var green:	CGFloat = 0
        var blue:	CGFloat = 0
        var alpha:	CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return NSString(format:"#%06x", rgb).uppercased as String
    }
    
    /// 短的16进制字符串
    public var yb_shortHexString: String? {
        let string = yb_hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string.characters)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else {
            return nil
        }
        return  "#" + "\(chrs[0])\(chrs[2])\(chrs[4])"
    }
    
    /// 16进制字符串
    public var yb_shortHexOrHexString: String {
        return yb_shortHexString ?? yb_hexString
    }
    
    /// 获取任意的颜色
    public static var yb_random: UIColor {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return UIColor(yb_red: r, green: g, blue: b)!
    }
}

// MARK: - 初始化构造器
public extension UIColor {
    
    /// 使用16进制数据创建颜色(example: 0xDECEB5)
    ///
    /// - Parameters:
    ///   - hex: 16进制数据
    ///   - alpha: 透明度 (default is 1).
    public convenience init?(yb_hex: Int, alpha: CGFloat = 1) {
        var trans = alpha
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (yb_hex >> 16) & 0xff
        let green = (yb_hex >> 8) & 0xff
        let blue = yb_hex & 0xff
        self.init(yb_red: red, green: green, blue: blue, alpha: trans)
    }
    
    /// SwifterSwift: 使用十六进制字符串创建颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串 (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F).
    ///   - alpha: 透明度 (default is 1).
    public convenience init?(yb_hexString: String, alpha: CGFloat = 1) {
        var string = ""
        if yb_hexString.lowercased().hasPrefix("0x") {
            string =  yb_hexString.replacingOccurrences(of: "0x", with: "")
        } else if yb_hexString.hasPrefix("#") {
            string = yb_hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = yb_hexString
        }
        if string.characters.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.characters.forEach({ str.append(String(repeating: String($0), count: 2)) })
            string = str
        }
        guard let hexValue = Int(string, radix: 16) else {
            return nil
        }
        self.init(yb_hex: Int(hexValue), alpha: alpha)
    }
    
    
    /// SwifterSwift: 使用可选透明的RGB值创建UIColor
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - alpha: optional transparency value (default is 1).
    public convenience init?(yb_red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        guard yb_red >= 0 && yb_red <= 255 else {
            return nil
        }
        guard green >= 0 && green <= 255 else {
            return nil
        }
        guard blue >= 0 && blue <= 255 else {
            return nil
        }
        var trans = alpha
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        self.init(red: CGFloat(yb_red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
}

extension UIColor {
    
    /// 根据RGB值获取颜色，不需要要除255
    ///
    /// - Parameters:
    ///   - red: 红的值
    ///   - green: 绿色值
    ///   - blue: 蓝色值
    ///   - alpha: 透明度(默认1)
    /// - Returns: 返回颜色
    class func YB_RGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    /// 根据黑白色值与透明度创建颜色
    ///
    /// - Parameters:
    ///   - write: 白色值
    ///   - alpha: 透明度(默认1)
    /// - Returns: 返回颜色
    class func YB_Write(write: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(white: write / 255.0, alpha: alpha)
    }
    
    
    /// 创建随机颜色
    ///
    /// - Returns: 返回颜色
    class func YB_Random() -> UIColor {
        let red = arc4random_uniform(255)
        let green = arc4random_uniform(255)
        let blue = arc4random_uniform(255)
        return UIColor.YB_RGB(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}

/// 自定义颜色结构体
struct YBLinearColor {
    
    /// 红色
    var red:  CGFloat = 0
    var green:  CGFloat = 0
    var blue:  CGFloat = 0
    var alpha:  CGFloat = 0
    var location:  CGFloat = 0
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1, location: CGFloat) {
        if red > 255 {
            self.red = 255
        } else if red < 0 {
            self.red = 0
        } else {
            self.red = red
        }
        if green > 255 {
            self.green = 255
        } else if green < 0 {
            self.green = 0
        } else {
            self.green = green
        }
        if blue > 255 {
            self.blue = 255
        } else if blue < 0 {
            self.blue = 0
        } else {
            self.blue = blue
        }
        if alpha > 1 {
            self.alpha = 1
        } else if alpha < 0 {
            self.alpha = 0
        } else {
            self.alpha = alpha
        }
        if location > 1 {
            self.location = 1
        } else if location < 0 {
            self.location = 0
        } else {
            self.location = location
        }
    }
}

// MARK: - 渐变颜色
extension CGGradient {
    
    /// 创建渐变颜色
    ///
    /// - Parameter linearColors: 颜色数组
    /// - Returns: 返回创建好的渐变颜色
    class func yb_create(linearColors: [YBLinearColor]) -> CGGradient? {
        var compoents = [CGFloat]()
        var locations = [CGFloat]()
        for item in linearColors {
            compoents.append(item.red / 255)
            compoents.append(item.green / 255)
            compoents.append(item.blue / 255)
            compoents.append(item.alpha)
            locations.append(item.location)
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        return CGGradient(colorSpace: colorSpace, colorComponents: compoents, locations: locations, count: linearColors.count)
    }
}
