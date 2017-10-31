//
//  UIImageExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit


// MARK: - 属性
public extension UIImage {
	
	/// 获取图片大小(字节)
	public var yb_bytesSize: Int {
		return UIImageJPEGRepresentation(self, 1)?.count ?? 0
	}
	
	/// 获取图片大小(kb)
	public var yb_kilobytesSize: Int {
		return yb_bytesSize / 1024
	}
	
	/// 通过原图片渲染
	public var yb_original: UIImage {
		return withRenderingMode(.alwaysOriginal)
	}
	
	/// 通过 alwaysTemplate 渲染 .alwaysTemplate
	public var template: UIImage {
		return withRenderingMode(.alwaysTemplate)
	}
	
}


// MARK: - 方法
public extension UIImage {
	
	/// 压缩图片
	///
	/// - Parameter quality: 压缩成JPEG格式（0.0-1.0）默认0.5
	/// - Returns: 返回压缩的图片
	public func yb_compressed(quality: CGFloat = 0.5) -> UIImage? {
		guard let data = yb_compressedData(quality: quality) else {
			return nil
		}
		return UIImage(data: data)
	}
	
	/// 将图片转成Data
	///
	/// - Parameter quality: 压缩成JPEG格式（0.0-1.0）默认0.5
	/// - Returns: optional Data (if applicable).
	public func yb_compressedData(quality: CGFloat = 0.5) -> Data? {
		return UIImageJPEGRepresentation(self, quality)
	}
	
	/// 图片裁剪
	///
	/// - Parameter rect: CGRect to crop UIImage to.
	/// - Returns: cropped UIImage
	public func yb_cropped(to rect: CGRect) -> UIImage {
		guard rect.size.height < size.height && rect.size.height < size.height else {
			return self
		}
		guard let image: CGImage = cgImage?.cropping(to: rect) else {
			return self
		}
		return UIImage(cgImage: image)
	}
	
	/// 图片通过纵横比缩放到指定高度
	///
	/// - Parameters:
	///   - toHeight: 新的高度
	///   - orientation: 可选的图片取向 (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
	public func yb_scaled(toHeight: CGFloat, with orientation: UIImageOrientation? = nil) -> UIImage? {
		let scale = toHeight / size.height
		let newWidth = size.width * scale
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: toHeight))
		draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}
	
	/// 图片通过纵横比缩放到指定宽度
	///
	/// - Parameters:
	///   - toWidth: new width.
	///   - orientation: optional UIImage orientation (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
	public func yb_scaled(toWidth: CGFloat, with orientation: UIImageOrientation? = nil) -> UIImage? {
		let scale = toWidth / size.width
		let newHeight = size.height * scale
		UIGraphicsBeginImageContext(CGSize(width: toWidth, height: newHeight))
		draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}
    
    /// 将图片缩小成指定大小
    ///
    /// - Parameters:
    ///   - maxWith: 最大宽度
    ///   - maxHeight: 最大高度
    /// - Returns: 返回图片
    func yb_scaled(maxWith: CGFloat, maxHeight: CGFloat) -> UIImage? {
        // 判断以那个方向缩小
        var imageWith: CGFloat = 0
        var imageHeight: CGFloat = 0
        if size.width / size.height > maxWith / maxHeight { // 以宽度作为缩放
            imageWith = maxWith
            imageHeight = size.height * (imageWith / size.width)
        }else{ // 以高度作为缩放
            imageHeight = maxHeight
            imageWith = size.width * (imageHeight / size.height)
        }
        // 获取上下文
        UIGraphicsBeginImageContext(CGSize(width: imageWith, height: imageHeight))
        // 画图
        draw(in: CGRect(x: 0, y: 0, width: imageWith, height: imageHeight))
        // 获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return image
    }
	
	/// 图片填充颜色
	///
	/// - Parameter color: color to fill image with.
	/// - Returns: UIImage filled with given color.
	public func yb_filled(withColor color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		color.setFill()
		guard let context = UIGraphicsGetCurrentContext() else {
			return self
		}
		
		context.translateBy(x: 0, y: size.height)
		context.scaleBy(x: 1.0, y: -1.0);
		context.setBlendMode(CGBlendMode.normal)
		
		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		guard let mask = self.cgImage else {
			return self
		}
		context.clip(to: rect, mask: mask)
		context.fill(rect)
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return newImage
	}
	
    /// 将图片保存到本地
    ///
    /// - Parameter url: 图片保存的路径
    public func yb_saveLocal(url: String) {
        let data = UIImageJPEGRepresentation(self, 1.0)
        try? (data as! NSData).write(toFile: url, options: NSData.WritingOptions.atomic)
    }
    
    /// 图片裁剪指定大小
    /// 主要的目的是节省CPU GPU的消耗
    /// - Parameters:
    ///   - size: 图片裁剪成指定大小
    ///   - isCornerRadius: 是否圆角
    ///   - borderWidth: 圆角边框宽度
    ///   - borderColor: 圆角颜色
    ///   - bgColor: 背景的颜色（主要目的是图片圆角的时候出图层叠加会出现性能上的问题）
    /// - Returns: 返回创建好的图片
    public func yb_to(size: CGSize, isCornerRadius: Bool = false, borderWidth: CGFloat = 1, borderColor: UIColor? = nil, bgColor: UIColor? = nil) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        let rect = CGRect(origin: CGPoint(), size: size)
        // 绘制背景颜色
        if let bgColor = bgColor {
            bgColor.setFill()
            UIRectFill(rect)
        }
        // 绘制圆角
        var path: UIBezierPath?
        if isCornerRadius {
            path = UIBezierPath(rect: rect)
            path?.addClip()
        }
        draw(in: rect)
        if let borderColor = borderColor, path != nil {
            borderColor.setStroke()
            path?.lineWidth = borderWidth
            path?.stroke()
        }
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
}


// MARK: - 构造方法
public extension UIImage {
	
	/// 根据大小跟颜色获取一张图片
	///
	/// - Parameters:
	///   - color: 图片颜色
	///   - size: 图片大小
	public convenience init(tb_color: UIColor, size: CGSize) {
		UIGraphicsBeginImageContextWithOptions(size, false, 1)
		tb_color.setFill()
		UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
		guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
			self.init()
			return
		}
		UIGraphicsEndImageContext()
		guard let aCgImage = image.cgImage else {
			self.init()
			return
		}
		self.init(cgImage: aCgImage)
	}
    
    
    /// 直接填写字符串获取图片
    ///
    /// - Parameter name: 返回图片
    public convenience init?(_ name: String) {
        self.init(named: name)
    }
}
#endif
