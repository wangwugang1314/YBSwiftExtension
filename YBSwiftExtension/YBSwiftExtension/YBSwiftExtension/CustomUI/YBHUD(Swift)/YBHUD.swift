//
//  YBHUD.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/8/3.
//  Copyright © 2017年 王亚彬. All rights reserved.
//  pod 'MBProgressHUD', '~> 1.0.0'

import UIKit
import MBProgressHUD

/// 显示状态
///
/// - success: 成功
/// - error: 失败
/// - info: 消息
enum YBHUDShow: String {
    case success = "success"
    case error = "error"
    case info = "info"
}

/// 进度条显示类型
///
/// - inRound: 内圆环
/// - bar: 进度条
/// - round: 圆环
enum YBHUDProgressType {
    case inRound
    case bar
    case round
}

// MARK: - 属性
class YBHUD: NSObject {
    
    /// 单利
    static let shared = YBHUD()

    /// 获取window
    var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    /// 上次显示的位置
    weak var mbHUD: MBProgressHUD?
    
    /// 进度完成是否隐藏
    var progressFinishIsHid = true
}

// MARK: - HUD基本配置
extension MBProgressHUD {
    
    // 基本设置（基本是一次性设置）
    func baseSet () {
        // 延时显示
        graceTime = 0
        
        // 最小显示时间
        minShowTime = 0
        
        // 从父试图隐藏的时候默认删除
        removeFromSuperViewOnHide = true
        
        // 内容的颜色(默认传给子试图)默认为班通明的黑色，如果设置为nil可以单独设置颜色
        contentColor = UIColor.white
        
        // 动画类型
        animationType = .fade
        
        // 设置试图弹出位置 CGPointMake(0.f, MBProgressMaxOffset) 出现在最底边
        // offset
        
        // 边沿的距离(默认为20)
        margin = 20
        
        // 弹窗大小 默认为0没有最小大小
        minSize = CGSize(width: 0, height: 0)
        
        // 是否长宽相等
        isSquare = false
        
        // 毛玻璃效果
        areDefaultMotionEffectsEnabled = true
        
        // 背景颜色(就好比以一个蒙版)
        // backgroundView.style = .solidColor;
        // backgroundView.color = UIColor(white: 0, alpha: 0.1);
    }
}

// MARK: - 私有方法
extension YBHUD {
    
    /// 显示试图
    ///
    /// - Parameters:
    ///   - to: 设置到指定试图
    ///   - customView: 自定义试图
    ///   - type: 显示类型
    ///   - title: 标题
    ///   - detil: 详情
    ///   - finish: 完成回调
    func show(to: UIView? = nil, customView: UIView? = nil, type: MBProgressHUDMode = .customView, title: String, detil: String? = nil, offset: CGPoint? = nil, finish: (() -> ())? = nil) {
        var toView: UIView! = to
        // 判断是否有父试图
        if toView == nil {
            if window == nil {
                print("此刻window为空不能显示")
                return
            }
            toView = window
        }
        // 判断是否有弹出框（如果有隐藏）
        mbHUD?.hide(animated: false)
        mbHUD = MBProgressHUD.showAdded(to: toView, animated: true)
        mbHUD?.baseSet()
        mbHUD?.mode = type
        mbHUD?.label.text = title
        mbHUD?.detailsLabel.text = detil
        mbHUD?.completionBlock = finish
        if let offset = offset {
            mbHUD?.offset = offset
        }
        if type == .customView && customView != nil {
            mbHUD?.customView = customView
        }
    }
}


// MARK: - 一瞬间显示
extension YBHUD {
    
    /// 显示（成功，失败，消息）
    ///
    /// - Parameters:
    ///   - type: 显示的类型
    ///   - title: 标题
    ///   - to: 显示到指定试图
    ///   - detil: 详情
    ///   - finish: 完成回调
    class func show(type: YBHUDShow, title: String, to: UIView? = nil,  detil: String? = nil, finish: (() -> ())? = nil) {
        let path = Bundle.main.bundlePath + "/YBHUD.bundle/" + type.rawValue
        let image = UIImage(contentsOfFile: path)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        YBHUD.shared.show(to: to, customView: imageView, type: .customView, title: title, detil: detil, finish: finish)
        hideAfter()
    }
    
    /// 底部显示文字
    ///
    /// - Parameters:
    ///   - to: 显示到指定试图
    ///   - title: 标题
    ///   - detil: 详情
    ///   - afterHid: 显示完成是否隐藏
    ///   - finish: 完成后调用
    class func showBottomText(to: UIView? = nil, title: String, detil: String? = nil, afterHid: Bool = true, finish: (() -> ())? = nil) {
        YBHUD.shared.show(to: to, type: .text, title: title, detil: detil, offset: CGPoint(x: 0, y: MBProgressMaxOffset), finish: finish)
        if afterHid {
            hideAfter()
        }
    }
}

// MARK: - 菊花
extension YBHUD {
    
    /// 菊花显示
    ///
    /// - Parameters:
    ///   - to: 显示到指定试图
    ///   - title: 标题
    ///   - detil: 详情
    ///   - finish: 完成回调
    class func showActivity(to: UIView? = nil, title: String, detil: String? = nil, finish: (() -> ())? = nil) {
        YBHUD.shared.show(to: to, type: .indeterminate, title: title, detil: detil, finish: finish)
    }
}

// MARK: - 进度
extension YBHUD {
    
    /// 显示进度条
    ///
    /// - Parameters:
    ///   - to: 显示到指定试图
    ///   - type: 进度条类型
    ///   - title: 标题
    ///   - detil: 详情
    ///   - progress: 初始进度
    ///   - finishIsHid: 完成是否隐藏
    ///   - finish: 完成回调
    class func showProgress(to: UIView? = nil, type: YBHUDProgressType = .bar, title: String, detil: String? = nil, progress: Float = 0, finishIsHid: Bool = true, finish: (() -> ())? = nil) {
        var state = MBProgressHUDMode.determinateHorizontalBar
        switch type {
        case .inRound:
            state = .determinate
        case .round:
            state = .annularDeterminate
        default:
            break
        }
        YBHUD.shared.progressFinishIsHid = finishIsHid
        YBHUD.shared.show(to: to, type: state, title: title, detil: detil, finish: finish)
        YBHUD.shared.mbHUD?.progress = progress
    }
    
    /// 设置进度
    ///
    /// - Parameters:
    ///   - progress: 进度（0-1）
    ///   - title: 标题
    ///   - detil: 详情
    class func setProgress(_ progress: Float, title: String? = nil, detil: String? = nil) {
        guard let _ = shared.mbHUD else {
            print("进度条没有显示不能设置")
            return
        }
        if progress >= 1 {
            hideAfter(0.3)
        }
        YBHUD.shared.mbHUD?.progress = progress
        if let title = title {
            YBHUD.shared.mbHUD?.label.text = title
        }
        if let detil = detil {
            YBHUD.shared.mbHUD?.detailsLabel.text = detil
        }
    }
}

// MARK: - 隐藏
extension YBHUD {
    
    /// 隐藏显示
    class func hide () {
        YBHUD.shared.mbHUD?.hide(animated: true)
    }
    
    /// 隐藏显示
    ///
    /// - Parameter after: 隐藏时间
    class func hideAfter (_ after: TimeInterval = 2.0) {
        YBHUD.shared.mbHUD?.hide(animated: true, afterDelay: after)
    }
}
