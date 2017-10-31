//
//  UIImageViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/25/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - 构造方法
public extension UIImageView {
    
    /// 创建图片试图
    ///
    /// - Parameters:
    ///   - named: 图片名称
    ///   - contentMode: 填充模式
    convenience init(named: String = "", contentMode: UIViewContentMode) {
        self.init(image: UIImage(named: named))
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
}

// MARK: - Methods
public extension UIImageView {
	
	/// 设置图片URL
	///
	/// - Parameters:
	///   - url: 图片的URL
	///   - contentMode: 设置图片的填充模式 (default is .scaleAspectFit).
	///   - placeHolder: 站位图片
	///   - completionHandler: 完成处理函数 (default is nil).
	public func yb_download(from url: URL,
	                     contentMode: UIViewContentMode = .scaleAspectFit,
	                     placeholder: UIImage? = nil,
	                     completionHandler: ((UIImage?) -> Void)? = nil) {
		
		image = placeholder
		self.contentMode = contentMode
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data,
				let image = UIImage(data: data)
				else {
					completionHandler?(nil)
					return
			}
			DispatchQueue.main.async() { () -> Void in
				self.image = image
				completionHandler?(image)
			}
			}.resume()
	}
	
	/// 模糊图像试图
	///
	/// - Parameter style: UIBlurEffectStyle (default is .light).
	public func yb_blur(withStyle style: UIBlurEffectStyle = .light) {
		let blurEffect = UIBlurEffect(style: style)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		addSubview(blurEffectView)
		clipsToBounds = true
	}
	
	/// 图像试图的模糊版本
	///
	/// - Parameter style: UIBlurEffectStyle (default is .light).
	/// - Returns: blurred version of self.
	public func yb_blurred(withStyle style: UIBlurEffectStyle = .light) -> UIImageView {
		let imgView = self
		imgView.yb_blur(withStyle: style)
		return imgView
	}
	
}
