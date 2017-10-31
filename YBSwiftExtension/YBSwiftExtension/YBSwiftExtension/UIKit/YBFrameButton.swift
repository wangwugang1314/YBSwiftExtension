//
//  YBBttton.swift
//  weiBo
//
//  Created by 王亚彬 on 2017/7/18.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit

/// 按钮类型
///
/// - horizon: 水平
/// - vertical: 垂直
enum YBFrameButtonType {
    case horizon
    case vertical
    case centerImage
}

/// NavigationBar 上的按钮
/// 主要用来设置按钮里面图片文字的位置
class YBFrameButton: UIButton {
    
    // 图片文字比例
    // 图片大小
    private var imageSize: CGSize
    // 类型
    private var frameButtonType: YBFrameButtonType?
    // 图片比例
    private var imageScale: CGFloat = 0
    // 文字比例
    private var textScale: CGFloat = 0
    // 文字高度
    private var textHeight: CGFloat = 0
 
    /// 自定义按钮（图片及文字位置）
    ///
    /// - Parameters:
    ///   - type: 排布方向
    ///   - imageSize: 图片大小
    ///   - imageScale: 图片开会位置比例
    ///   - textHeight: 文字高度
    ///   - textScale: 文字开始位置比例
    init(type: YBFrameButtonType, imageSize: CGSize, imageScale: CGFloat, textHeight: CGFloat, textScale: CGFloat) {
        self.imageSize = imageSize
        super.init(frame: CGRect())
        self.imageScale = imageScale
        self.textScale = textScale
        self.frameButtonType = type
        self.textHeight = textHeight
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.textAlignment = type == .horizon ? .left : .center
    }

    /// 指定图片大小图片会在按钮的正中间
    init(imageSize: CGSize) {
        self.imageSize = imageSize
        super.init(frame: CGRect())
    }

    
    required init?(coder aDecoder: NSCoder) {
        self.imageSize = CGSize()
        super.init(coder: aDecoder)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        guard let frameButtonType = frameButtonType, contentRect.size.width > 0 else {
            return CGRect()
        }
        var x: CGFloat = 0
        var y: CGFloat = 0
        if frameButtonType == .horizon {
            x = contentRect.size.width * imageScale
            y = (contentRect.size.height - imageSize.height) * 0.5
        } else {
            x = (contentRect.size.width - imageSize.width) * 0.5
            y = contentRect.size.height * imageScale
        }
        return CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        guard let frameButtonType = frameButtonType, contentRect.size.width > 0 else {
            return CGRect()
        }
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        let h: CGFloat = textHeight
        if frameButtonType == .horizon {
            x = contentRect.size.width * textScale
            w = contentRect.size.width - x
        } else {
            y = contentRect.size.width * textScale
            w = contentRect.size.width
        }
        return CGRect(x: x, y: y, width: w, height: h)
    }
}

