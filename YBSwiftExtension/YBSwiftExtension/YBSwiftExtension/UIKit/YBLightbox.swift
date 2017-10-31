//
//  LightboxExtension.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/10/11.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit
import Lightbox

class YBLightbox {
    
    class func show(imageSrcs: [String], index: Int) {
        // 设置加载模型
        let lightboxImages = imageSrcs.map { (item) -> LightboxImage in
            guard let url = URL(string: item) else {
                return LightboxImage(image: UIImage())
            }
            return LightboxImage(imageURL: url)
        }
        // 配置图片加载
        LightboxConfig.loadImage = {
            imageView, URL, completion in
            imageView.yb_kf(url: URL, completionHandler: { (image, error, _, _) in
                completion?( error, image)
            })
        }
        LightboxConfig.CloseButton.text = "关闭"
        let lightbox = LightboxController(images: lightboxImages, startIndex: index)
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            vc.present(lightbox, animated: true, completion: nil)
        }
    }
}
