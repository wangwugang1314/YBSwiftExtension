//
//  UILabelExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - 构造方法
public extension UILabel {
    
    /// 设置导航栏标题
    ///
    /// - Parameter navTitle: 标题
    convenience init(navTitle: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        textColor = UIColor.white
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 20)
        text = navTitle
    }
    
    /// 创建label
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - fontSize: 字体大小
    ///   - color: 字体颜色
    ///   - textAlignment: 对齐方式(默认居中对齐)
    ///   - lines: 是否换行(默认1)
    convenience init(text: String = "", fontSize: CGFloat = 18, color: UIColor = UIColor.darkGray, textAlignment: NSTextAlignment = .center, lines: Int = 1) {
        self.init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = color
        self.numberOfLines = lines
        self.textAlignment = textAlignment
    }
}

// MARK: - Methods
public extension UILabel {
	
	/// 获取标签要求的高度
	public var yb_requiredHeight: CGFloat {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = text
		label.attributedText = attributedText
		label.sizeToFit()
		return label.frame.height
	}
}
