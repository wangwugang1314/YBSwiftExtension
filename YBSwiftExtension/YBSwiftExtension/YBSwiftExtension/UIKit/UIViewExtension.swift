//
//  UIView+Extension.swift
//  weiBoSwift
//
//  Created by MAC on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit


/// 边框
///
/// - left: 左边
/// - right: 右边
/// - top: 顶部
/// - bottom: 底部
enum YBViewBorder {
    case left
    case right
    case top
    case bottom
}

/// 圆角单位.
///
/// - degrees: 度.
/// - radians: 弧度.
public enum YBAngleUnit {
    case degrees
    case radians
}

/// 摇一摇
///
/// - horizontal: Shake left and right.
/// - vertical: Shake up and down.
public enum YBShakeDirection {
    case horizontal
    case vertical
}

/// 震撼的动画类型。
///
/// - linear: linear animation.
/// - easeIn: easeIn animation
/// - easeOut: easeOut animation.
/// - easeInOut: easeInOut animation.
public enum YBShakeAnimationType {
    case linear
    case easeIn
    case easeOut
    case easeInOut
}

/// 动画线性类型
enum YBAnimatinLineType: String {
    case linear = "linear"
    case easeIn = "easeIn"
    case easeOut = "easeOut"
    case easeInEaseOut = "easeInEaseOut"
    case normal = "default"
}

/// 平移类型
enum YBTranslationDirection: Int {
    case horizon
    case vertical
}

/// 动画类型
enum YBAnimatinType: String {
    case all = "YBAnimatinType_all"
    case rotation = "YBAnimatinType_rotation"
    case translationX = "YBAnimatinType_translationX"
    case translationY = "YBAnimatinType_translationY"
}

// MARK: - 属性
public extension UIView {
    
    @IBInspectable
    /// 边框颜色
    public var yb_borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable
    /// 边框宽度
    public var yb_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    /// 圆角半径
    public var yb_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// 是否是第一响应者.
    public var yb_firstResponder: UIView? {
        guard !isFirstResponder else {
            return self
        }
        for subView in subviews {
            if subView.isFirstResponder {
                return subView
            }
        }
        return nil
    }
    
    // 试图高度
    public var yb_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// 检查试图是否是 RTL 格式.
    public var yb_isRightToLeft: Bool {
        if #available(iOS 10.0, *, tvOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            return false
        }
    }
    
    /// 获取试图的截图
    public var yb_screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0);
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    @IBInspectable
    /// 阴影颜色
    public var yb_shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    /// 阴影偏移
    public var yb_shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    /// 阴影的不透明度
    public var yb_shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    /// 阴影的圆角半径
    public var yb_shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Size of view.
    public var yb_size: CGSize {
        get {
            return frame.size
        }
        set {
            yb_width = newValue.width
            yb_height = newValue.height
        }
    }
    
    /// 获取试图所在的控制器
    public var yb_parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// 试图的宽度
    public var yb_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// x 点
    public var yb_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// y origin of view.
    public var yb_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var yb_centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    public var yb_centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
}

// MARK: - 方法(常用)
public extension UIView {
    
    /// 设置一些或者所有的圆角
    ///
    /// - Parameters:
    ///   - corners: 改变角的数组 (example: [.bottomLeft, .topRight]).
    ///   - radius: 圆角半径
    public func yb_roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// 给试图添加阴影
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    public func yb_addShadow(ofColor color: UIColor = UIColor(yb_hex: 0x137992)!,
                          radius: CGFloat = 3,
                          offset: CGSize = .zero,
                          opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = true
    }
    
    /// 向视图添加子视图数组。
    ///
    /// - Parameter subviews: array of subviews to add to self.
    public func yb_addSubviews(_ subviews: [UIView]) {
        subviews.forEach({self.addSubview($0)})
    }
    
    /// 加载bib
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    public class func yb_loadFromNib(named name: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    /// 移除所有的子试图
    public func yb_removeSubviews() {
        subviews.forEach({$0.removeFromSuperview()})
    }
    
    /// 从视图中删除所有的手势识别器。
    public func yb_removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
    
    /// SwifterSwift: Anchor center X into current view's superview with a constant margin value.
    ///
    /// - Parameter constant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *) public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// SwifterSwift: Anchor center Y into current view's superview with a constant margin value.
    ///
    /// - Parameter withConstant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *) public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// SwifterSwift: Anchor center X and Y into current view's superview
    @available(iOS 9, *) public func anchorCenterSuperview() {
        // https://videos.letsbuildthatapp.com/
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
}

// MARK: - 动画
extension UIView {
    
    /// 旋转动画
    ///
    /// - Parameters:
    ///   - toValue: toValue(角度 Float.pi)
    ///   - repeatCount: 重复次数
    ///   - duration: 持续时间
    ///   - animationType: 动画类型
    func yb_rotationAnimation(toValue: Float, repeatCount: Float, duration: CFTimeInterval, animationType: YBAnimatinLineType = .linear) {
        let anim = CABasicAnimation()
        anim.keyPath = "transform.rotation.z"
        anim.toValue = NSNumber(floatLiteral: Double(toValue))
        anim.repeatCount = repeatCount
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: animationType.rawValue)
        // 动画完成不删除，如果试图销毁动画对象也会销毁
        anim.isRemovedOnCompletion = false
        layer.add(anim, forKey: YBAnimatinType.rotation.rawValue)
    }
    
    /// 平移动画
    ///
    /// - Parameters:
    ///   - toValue: toValue(角度 Float.pi)
    ///   - repeatCount: 重复次数
    ///   - duration: 持续时间
    ///   - animationType: 动画类型
    func yb_translationAnimation(toValue: Float, repeatCount: Float, duration: CFTimeInterval, translationDirection: YBTranslationDirection, animationType: YBAnimatinLineType = .linear) {
        let anim = CABasicAnimation()
        var key = ""
        switch translationDirection {
        case .horizon:
            anim.keyPath = "transform.translation.x"
            key = YBAnimatinType.translationX.rawValue
        case .vertical:
            anim.keyPath = "transform.translation.y"
            key = YBAnimatinType.translationY.rawValue
        }
        anim.toValue = NSNumber(floatLiteral: Double(toValue))
        anim.repeatCount = repeatCount
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: animationType.rawValue)
        anim.isRemovedOnCompletion = false
        layer.add(anim, forKey: key)
    }
    
    /// 清除动画
    func yb_removeAnimation(animationType: YBAnimatinType) {
        switch animationType {
        case .all:
            layer.removeAllAnimations()
        default :
            layer.removeAnimation(forKey: animationType.rawValue)
        }
    }
    
    /// 动画设置圆角半径
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - duration: 动画持续时间
    func yb_cornerRadiusAnimation(cornerRadius: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation()
        animation.keyPath = "cornerRadius"
        animation.fromValue = layer.cornerRadius
        animation.toValue = cornerRadius
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        layer.cornerRadius = cornerRadius
        layer.add(animation, forKey: nil)
    }
    
    /// 淡入视图。
    ///
    /// - Parameters:
    ///   - duration: 持续时间
    ///   - completion: 完成后调用 (default is nil)
    public func yb_fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /// 淡出视图。
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    public func yb_fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    /// 角度指定旋转
    ///
    /// - Parameters:
    ///   - angle: 旋转角度.
    ///   - type: 角度类型.
    ///   - animated: 是否使用动画 (default is true).
    ///   - duration: 动画持续时间 (default is 1 second).
    ///   - completion: 完成回调 (default is nil).
    public func yb_rotate(byAngle angle : CGFloat, ofType type: YBAngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }
    
    /// 角度到指定旋转
    ///
    /// - Parameters:
    ///   - angle: 旋转角度.
    ///   - type: 角度类型.
    ///   - animated: 是否使用动画 (default is false).
    ///   - duration: 动画持续时间 (default is 1 second).
    ///   - completion: 完成回调 (default is nil).
    public func yb_rotate(toAngle angle: CGFloat, ofType type: YBAngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }
    
    /// 按照比例缩放
    ///
    /// - Parameters:
    ///   - offset: 缩放大小
    ///   - animated: set true to animate scaling (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    public func yb_scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion:((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }
    
    /// 摇一摇
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    public func yb_shake(direction: YBShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: YBShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
        
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
}

// MARK: - 自定义的
extension UIView {
    
    /// 阴影颜色
    func yb_shadow(color: UIColor, opacity: Float, offsetX: CGFloat, offsetY: CGFloat, radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowRadius = radius
    }

    /// 设置边框
    ///
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func yb_border(borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    
    /// 设置边框
    ///
    /// - Parameters:
    ///   - borderStyles: 指定边框
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func yb_border(borderStyles:[YBViewBorder], borderWidth: CGFloat, borderColor: UIColor, alpha: CGFloat = 1) {
        for style in borderStyles {
            let lineView = UIView()
            lineView.alpha = alpha
            lineView.backgroundColor = borderColor
            var duration: YBLayoutAlignment = .inBottom
            switch style {
            case .left:
                duration = .inLeft
            case .right:
                duration = .inRight
            case .top:
                duration = .inTop
            case .bottom:
                duration = .inBottom
            }
            yb_alignment(view: lineView, duration: duration, width: borderWidth)
        }
    }
    
    /// 设置边框(用UIView填充)
    ///
    /// - Parameters:
    ///   - borderStyle: 边类型
    ///   - lineWidth: 线宽
    ///   - lineColor: 线颜色
    ///   - sideInterval: 边距
    func yb_border(borderStyle: [YBViewBorder], lineWidth: CGFloat, lineColor: UIColor, sideInterval: CGFloat = 0) {
        for style in borderStyle {
            let lineView = UIView()
            lineView.backgroundColor = lineColor
            var direction = YBLayoutAlignment.inBottom
            switch style {
            case .left:
                direction = .inLeft
            case .top:
                direction = .inTop
            case .right:
                direction = .inRight
            case .bottom:
                direction = .inBottom
            }
            yb_alignment(view: lineView, duration: direction, width: lineWidth, sideInterval: sideInterval)
        }
    }
}
