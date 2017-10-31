//
//  YBLoadImage.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/8/30.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit
import Kingfisher

/*
 下载图片首先缓存到本地
 使用url绝对地址进行 KEY 缓存
 /// 占位符 -------
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet
 
 /// 指示器 -------
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#with-a-placeholder-image-while-downloading
 
 /// 加载完成动画 -------
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#add-a-fade-transition-when-setting-image-after-downloaded
 
 /// 图片处理（圆角，模糊，颜色等，可以同时处理多个） -------
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#transform-downloaded-image-to-round-corner-before-displaying-and-caching
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#processor
 
 /// 缓存默认路径扩展
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#add-a-default-path-extension-to-each-cached-file
 
 /// 自定义下载器或者缓存
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#use-customized-downloader-and-cache-instead-of-the-default-ones
 
 /// 修改请求
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#modify-a-request-before-sending
 
 /// 授权
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#authentication-with-nsurlcredential
 
 /// 检查请求状态
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#check-http-status-code-and-determine-whether-it-is-valid
 
 /// 自定义会话配置
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#use-your-own-session-configuration-in-a-downloader
 
 /// 序列化
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#serializer
 
 /// 反序列化、序列化  格式隐藏
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#format-indicated-cache
 
 /// 自定义序列化器
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#create-and-use-your-own-serializer
 
 /// Prefetcher with UICollectionView or UITableView
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#use-prefetcher-with-uicollectionview-or-uitableview
 
 /// Animated GIF
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#animated-gif
 
 /// 只从GIF加载第一个
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#only-load-the-first-frame-from-gif

 /// 常用的图像扩展
 https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#useful-image-extensions
 
 public enum KingfisherOptionsInfoItem {
 
 这个成员的关联值是一个ImageCache对象。 Kingfisher使用指定的缓存对象处理 相关业务,包括试图检索缓存图像和存储下载的图片。
 case targetCache(ImageCache)
 
 这个成员的关联值应该是一个ImageDownloader对象。Kingfisher将使用这个下载器下载的图片。
 case downloader(ImageDownloader)
 ∂ç∂ç
 如果从网络下载的图片 Kingfisher将使用“ImageTransition这个枚举动画。从内存或磁盘缓存时默认过渡不会发生。如果需要,设置ForceTransition
 case transition(ImageTransition)
 
 有关“浮动”值将被设置为图像下载任务的优先级。值在0.0 ~ 1.0之间。如果没有设置这个选项,默认值(“NSURLSessionTaskPriorityDefault”)将被使用。
 case downloadPriority(Float)
 
 如果设置,将忽略缓存,开启一个下载任务的资源
 case forceRefresh
 
 如果设置 即使缓存的图片也将开启过渡动画
 case forceTransition
 
 如果设置，Kingfisher只会在内存中缓存值而不是磁盘
 case cacheMemoryOnly
 
 如果设置 Kingfisher只会从缓存中加载图片
 case onlyFromCache
 
 在使用之前在后台线程解码图像
 case backgroundDecode
 
 当从缓存检索图像时 这个成员的关联值将被用作目标队列的调度时回调。如果没 有设置, Kingfisher将使用主要quese回调
 case callbackDispatchQueue(DispatchQueue?)
 
 将检索到的图片数据转换成一个图时 这个成员变量将被用作图片缩放因子。图像分辨率,而不是屏幕尺寸。你可能处理时需要指定正确的缩放因子@2x或@3x Retina图像。
 case scaleFactor(CGFloat)
 
 是否所有的GIF应该加载数据。默认false，只显示GIF中第一张图片。如果true,所有的GIF数据将被加载到内存中进行解码。这个选项主要是用于内部的兼容性。你不应该把直接设置它。“AnimatedImageView”不会预加载所有数据,而一个正常的图像视图(“UIImageView”或“NSImageView”)将加载所有数据。选择使用相应的图像视图类型而不是设置这个选项。
 case preloadAllGIFData
 
 发送请求之前用于改变请求。这是最后的机会你可以修改请求。您可以修改请求一些定制的目的,如添加身份验证令牌头,进行基本的HTTP身份验证或类似的url映射。原始请求默认情况下将没有任何修改
 case requestModifier(ImageDownloadRequestModifier)
 
 下载完成时,处理器会将下载的数据转换为一个图像。如果缓存连接到下载器(当你正在使用KingfisherManager或图像扩展方法),转换后的图像也将被缓存
 case processor(ImageProcessor)
 
 提供一个CacheSerializer 可用于图像对象序列化成图像数据存储到磁盘缓存和从磁盘缓存将图片数据反序列化成图像对象
 case cacheSerializer(CacheSerializer)
 
 保持现有的图像同时设置另一个图像图像视图。通过设置这个选项,imageview的placeholder参数将被忽略和当前图像保持同时加载新图片
 case keepCurrentImageWhileLoading
 }
 
 */


import Kingfisher
// MARK: - 对Kingfisher扩展
extension UIImageView {
    
    /// 加载网络图片
    ///
    /// - Parameters:
    ///   - urlStr: 图片的url地址
    ///   - placeholder: 站位图片
    ///   - options: 选项
    ///   - progressBlock: 进度回调
    ///   - completionHandler: 完成回调
    func yb_kf(urlStr: String, placeholder: String = "", options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil) {
        if let url = URL(string: urlStr) {
            yb_kf(url: url,
                  placeholder: placeholder,
                  options: options,
                  progressBlock: progressBlock,
                  completionHandler: completionHandler)
        }
    }
    
    func yb_kf(url: URL, placeholder: String = "", options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil) {
        let placeholder = UIImage(named: placeholder)
        kf.setImage(with: url,
                    placeholder: placeholder,
                    options: options,
                    progressBlock: progressBlock,
                    completionHandler: completionHandler)
    }
    
    /// 取消下载任务
    func yb_kf_cancelDownloadTask() {
        kf.cancelDownloadTask()
    }
}

extension UIButton {
    
    /// 异步加载图片
    ///
    /// - Parameters:
    ///   - urlStr: 图片链接
    ///   - placeholder: 站位图片
    ///   - state: 状态
    ///   - options: 选项
    ///   - progressBlock: 进度回调
    ///   - completionHandler: 完成回调
    func yb_kf(urlStr: String, placeholder: String = "", state: UIControlState = .normal, options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil) {
        let placeholder = UIImage(named: placeholder)
        kf.setImage(with: URL(string: urlStr),
                    for: state,
                    placeholder: placeholder,
                    options: options,
                    progressBlock: progressBlock,
                    completionHandler: completionHandler)
    }
    
    /// 异步加载背景图片
    ///
    /// - Parameters:
    ///   - urlStr: 图片链接
    ///   - placeholder: 站位图片
    ///   - state: 状态
    ///   - options: 选项
    ///   - progressBlock: 进度回调
    ///   - completionHandler: 完成回调
    func yb_kf_bg(urlStr: String, placeholder: String = "", state: UIControlState = .normal, options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil) {
        let placeholder = UIImage(named: placeholder)
        kf.setBackgroundImage(with: URL(string: urlStr),
                              for: state,
                              placeholder: placeholder,
                              options: options,
                              progressBlock: progressBlock,
                              completionHandler: completionHandler)
    }
    
    /// 取消下载任务
    func yb_kf_cancelImageDownloadTask() {
        kf.cancelImageDownloadTask()
    }
    
    /// 取消下载任务
    func yb_kf_cancelBackgroundImageDownloadTask() {
        kf.cancelBackgroundImageDownloadTask()
    }
}

/// 缓存检查结果
struct YBImageCacheCheckResult {
    let cached: Bool
    let cacheType: CacheType?
}

/// 清除缓存类型
///
/// - memory: 内存
/// - disk: 磁盘
/// - expiredDiskCache: 过期或者超出的缓存
enum YBClearCacheType {
    case memory
    case disk
    case expiredDisk
}

// MARK: - 下载图片
class YBWebImage {
    
    /// 图片异步下载
    ///
    /// - Parameters:
    ///   - urlStr: 下载图片的URL
    ///   - options: 选项
    ///   - progressBlock: 进度回调
    ///   - completionHandler: 完成回调
    class func down(urlStr: String, options: KingfisherOptionsInfo? = nil, progressBlock: ImageDownloaderProgressBlock? = nil, completionHandler: ImageDownloaderCompletionHandler? = nil) {
        guard let imageUrl = URL(string: urlStr) else {
            completionHandler?(nil, NSError(domain: "路径错误", code: 404, userInfo: nil), nil, nil)
            return
        }
        ImageDownloader.default.downloadImage(with: imageUrl,
                                              retrieveImageTask: nil,
                                              options: options,
                                              progressBlock: progressBlock,
                                              completionHandler: completionHandler)
    }
    
    /// 图片异步缓存
    ///
    /// - Parameters:
    ///   - image: 需要缓存的图片
    ///   - key: 缓存图片的键值
    ///   - toDisk: 是否保存到磁盘（默认保存到磁盘）
    ///   - completionHandler: 完成回调
    class func store(image: UIImage, key: String, toDisk: Bool = true, completionHandler: (() -> Void)? = nil) {
        let data = UIImagePNGRepresentation(image)
        ImageCache.default.store(image,
                                 original: data,
                                 forKey: key,
                                 toDisk: toDisk,
                                 completionHandler: completionHandler)
    }
    
    /// 检查图片是否缓存
    ///
    /// - Parameter key: 缓存图片的键值
    /// - Returns: 返回缓存结果
    class func isCached(key: String) -> YBImageCacheCheckResult {
        let result = ImageCache.default.isImageCached(forKey: key)
        return YBImageCacheCheckResult(cached: result.cached, cacheType: result.cacheType)
    }
    
    /// 异步检索图片
    ///
    /// - Parameters:
    ///   - key: 图片的键值
    ///   - completionHandler: 完成回调
    class func retrieveImage(key: String, completionHandler: ((Image?, CacheType) -> ())?) {
        ImageCache.default.retrieveImage(forKey: key, options: nil, completionHandler: completionHandler)
    }
    
    /// 清除图片
    ///
    /// - Parameters:
    ///   - forKey: 键值
    ///   - fromDisk: 是否清除磁盘(如果是false只清除内存)
    ///   - completionHandler: 完成回调
    class func removeImage(forKey: String, fromDisk: Bool = true, completionHandler: (() -> Void)?) {
        ImageCache.default.removeImage(forKey: forKey, fromDisk: fromDisk, completionHandler: completionHandler)
    }
    
    /// 设置最大磁盘缓存大小
    ///
    /// - Parameter M: 单位是 M
    class func maxDiskCacheSize(M: UInt) {
        ImageCache.default.maxDiskCacheSize = M * 1024 * 1024
    }
    
    /// 计算磁盘缓存大小
    ///
    /// - Parameter completion: 完成回调(单位字节)
    class func calculateDiskCacheSize(completion: @escaping ((UInt) -> ())) {
        ImageCache.default.calculateDiskCacheSize(completion: completion)
    }
    
    /// 清除缓存
    ///
    /// - Parameter type: 清除的类型
    class func clearCache(type: YBClearCacheType) {
        switch type {
        case .memory:
            ImageCache.default.clearMemoryCache()
        case .disk:
            ImageCache.default.clearDiskCache()
        case .expiredDisk:
            ImageCache.default.cleanExpiredDiskCache()
        }
    }
    
    /// 设置最长缓存时间
    ///
    /// - Parameter day: 天
    class func setMaxCacheTime(day: UInt) {
        ImageCache.default.maxCachePeriodInSecond = TimeInterval(60 * 60 * 24 * day)
    }
    
    /// 设置下载超时时间
    ///
    /// - Parameter second: 秒
    class func downloadTimeout(second: TimeInterval) {
        ImageDownloader.default.downloadTimeout = second
    }
}

