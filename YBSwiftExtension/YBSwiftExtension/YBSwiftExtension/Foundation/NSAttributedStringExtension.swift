//
//  NSAttributedStringExtension.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/8/24.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit

/// 属性字符串类型
///
/// - font: NSFontAttributeName 设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
/// - textColor: NSForegroundColorAttributeName 设置字体颜色，取值为 UIColor对象，默认值为黑色
/// - backgroundColor: NSBackgroundColorAttributeName 设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
/// - ligatureAttribute: NSLigatureAttributeName 设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
/// - fontInterval: NSKernAttributeName 设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
/// - removeLine: NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
/// - removeLineColor: NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
/// - underline: NSUnderlineStyleAttributeName 设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
/// - underlineColor: NSUnderlineColorAttributeName 设置下划线颜色，取值为 UIColor 对象，默认值为黑色
/// - strokeWidth: NSStrokeWidthAttributeName 设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
/// - strokeColor: NSStrokeColorAttributeName 填充部分颜色，字体颜色，取值为 UIColor 对象
/// - shadow: NSShadowAttributeName 设置阴影属性，取值为 NSShadow 对象
/// - baselineOffset: NSBaselineOffsetAttributeName 设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
/// - obliqueness: NSObliquenessAttributeName 设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
/// - expansion: NSExpansionAttributeName 设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
/// - writeDuration: NSWritingDirectionAttributeName 设置文字书写方向，从左向右书写或者从右向左书写 NSTextWritingDirectionEmbedding
/// - isVertical: NSVerticalGlyphFormAttributeName 设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
/// - link: NSLinkAttributeName 设置链接属性，点击后调用浏览器打开指定URL地址
/// - attachment: NSAttachmentAttributeName 设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
/// - paragraphStyle: NSParagraphStyleAttributeName 设置文本段落排版格式，取值为 NSParagraphStyle 对象
enum YBAttributedType {
    case font(UIFont)
    case textColor(UIColor)
    case backgroundColor(UIColor)
    case ligatureAttribute(Bool)
    case fontInterval(Int)
    case removeLine(Bool)
    case removeLineColor(UIColor)
    case underline(NSUnderlineStyle)
    case underlineColor(UIColor)
    case strokeWidth(Int)
    case strokeColor(UIColor)
    case shadow(NSShadow)
    case baselineOffset(Float)
    case obliqueness(Float)
    case expansion(Float)
    case writeDuration(NSWritingDirection)
    case isVertical(Bool)
    case link(URL)
    case attachment(NSTextAttachment)
    case paragraphStyle(NSParagraphStyle)
}

extension NSAttributedString {
    
    convenience init(yb_str: String, types: [YBAttributedType] = [YBAttributedType]()) {
        var attributes = [String: Any]()
        for type in types {
            switch type {
            case let .font(value):
                attributes[NSFontAttributeName] = value
            case let .textColor(value):
                attributes[NSForegroundColorAttributeName] = value
            case let .backgroundColor(value):
                attributes[NSBackgroundColorAttributeName] = value
            case let .ligatureAttribute(value):
                attributes[NSLigatureAttributeName] = NSNumber(value: value ? 1 : 0)
            case let .fontInterval(value):
                attributes[NSKernAttributeName] = NSNumber(value: value)
            case let .removeLine(value):
                attributes[NSStrikethroughStyleAttributeName] = NSNumber(value: value ? 1 : 0)
            case let .removeLineColor(value):
                attributes[NSStrikethroughColorAttributeName] = value
            case let .underline(value):
                attributes[NSUnderlineStyleAttributeName] = NSNumber(value: value.rawValue)
            case let .underlineColor(value):
                attributes[NSUnderlineColorAttributeName] = value
            case let .strokeWidth(value):
                attributes[NSStrokeWidthAttributeName] = NSNumber(value: value)
            case let .strokeColor(value):
                attributes[NSStrokeColorAttributeName] = value
            case let .shadow(value):
                attributes[NSShadowAttributeName] = value
            case let .baselineOffset(value):
                attributes[NSBaselineOffsetAttributeName] = NSNumber(value: value)
            case let .obliqueness(value):
                attributes[NSObliquenessAttributeName] = NSNumber(value: value)
            case let .expansion(value):
                attributes[NSExpansionAttributeName] = NSNumber(value: value)
            case let .writeDuration(value):
                attributes[NSWritingDirectionAttributeName] = NSNumber(value: value.rawValue)
            case let .isVertical(value):
                attributes[NSVerticalGlyphFormAttributeName] = NSNumber(value: value ? 1 : 0)
            case let .link(value):
                attributes[NSLinkAttributeName] = value
            case let .attachment(value):
                attributes[NSAttachmentAttributeName] = value
            case let .paragraphStyle(value):
                attributes[NSParagraphStyleAttributeName] = value
            }
        }
        self.init(string: yb_str, attributes: attributes)
        
    }
}

// MARK: - 方法
extension NSAttributedString {
    
    /// 获取熟悉感字符串占空间的大小
    ///
    /// - Parameter width: 宽度（默认是最大宽度）
    /// - Returns: 返回占的大小
    func yb_size(width: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        let bounds = boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], context: nil)
        return bounds.size
    }
}
