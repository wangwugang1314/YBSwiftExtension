//
//  UIButtonExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - 构造方法
public extension UIButton {
    /// 创建按钮
    ///
    /// - Parameters:
    ///   - imageName: normal 图片
    ///   - selImageName: 选中的图片
    convenience init(image: String, higImage: String? = nil, selImage: String? = nil) {
        self.init()
        setImage(UIImage(named: image), for: .normal)
        if let selImage = selImage {
            setImage(UIImage(named: selImage), for: .selected)
        }
        if let higImage = higImage {
            setImage(UIImage(named: higImage), for: .highlighted)
        }
    }
    
    /// 创建按钮
    ///
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - backgroundImageName: 背景图片名称
    convenience init(image: String, bgImage: String, higImage: String? = nil, higBgImage: String? = nil, selImage: String? = nil, selBgImage: String? = nil) {
        self.init()
        setImage(UIImage(named: image), for: .normal)
        setBackgroundImage(UIImage(named: bgImage), for: .normal)
        if let higImage = higImage {
            setImage(UIImage(named: higImage), for: .highlighted)
        }
        if let higBgImage = higBgImage {
            setBackgroundImage(UIImage(named: higBgImage), for: .highlighted)
        }
        if let selImage = selImage {
            setImage(UIImage(named: selImage), for: .selected)
        }
        if let selBgImage = selBgImage {
            setBackgroundImage(UIImage(named: selBgImage), for: .selected)
        }
    }
    
    /// 创建按钮
    ///
    /// - Parameters:
    ///   - text: normal 文字
    ///   - selText: 选中的文字
    convenience init(text: String, selText: String) {
        self.init()
        setTitle(text, for: .normal)
        setTitle(selText, for: .selected)
    }
    
    /// 创建按钮
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - textColor: 文字颜色
    ///   - higTextColor: 高亮文字颜色
    ///   - bgImage: 背景图片
    ///   - higBgImage: 高亮背景图片
    convenience init(text: String, textColor: UIColor? = nil, higTextColor: UIColor? = nil, bgImage: String? = nil, higBgImage: String? = nil) {
        self.init()
        setTitle(text, for: .normal)
        if let textColor = textColor {
            setTitleColor(textColor, for: .normal)
        }
        if let higTextColor = higTextColor {
            setTitleColor(higTextColor, for: .highlighted)
        }
        if let bgImage = bgImage {
            setBackgroundImage(UIImage(named: bgImage), for: .normal)
        }
        if let higBgImage = higBgImage {
            setBackgroundImage(UIImage(named: higBgImage), for: .highlighted)
        }
    }
    
    /// 创建按钮
    ///
    /// - Parameters:
    ///   - text: 按钮文本
    ///   - textColor: 文字颜色
    ///   - fontSize: 文字大小
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - cornerRadius: 圆角大小
    convenience init(text: String, textColor: UIColor, fontSize: CGFloat, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat)  {
        self.init()
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    /// 创建按钮
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - textColor: 文字颜色
    ///   - font: 字体大小
    convenience init(text: String = "", textColor: UIColor, font: CGFloat) {
        self.init()
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: font)
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 0
    }
}

// MARK: - 属性
public extension UIButton {
	
	@IBInspectable
	/// 禁用状态的图片
	public var yb_imageForDisabled: UIImage? {
		get {
			return image(for: .disabled)
		}
		set {
			setImage(newValue, for: .disabled)
		}
	}
	
	@IBInspectable
	/// 高亮状态的图片
	public var yb_imageForHighlighted: UIImage? {
		get {
			return image(for: .highlighted)
		}
		set {
			setImage(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// 正常状态下的图片
	public var yb_imageForNormal: UIImage? {
		get {
			return image(for: .normal)
		}
		set {
			setImage(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// 选择状态下的图片
	public var yb_imageForSelected: UIImage? {
		get {
			return image(for: .selected)
		}
		set {
			setImage(newValue, for: .selected)
		}
	}
	
	@IBInspectable
	/// Disabled状态下的文字颜色
	public var yb_titleColorForDisabled: UIColor? {
		get {
			return titleColor(for: .disabled)
		}
		set {
			setTitleColor(newValue, for: .disabled)
		}
	}
	
	@IBInspectable
	/// highlighted状态下的文字颜色
	public var yb_titleColorForHighlighted: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// normal状态下的文字颜色
	public var yb_titleColorForNormal: UIColor? {
		get {
			return titleColor(for: .normal)
		}
		set {
			setTitleColor(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// selected状态下的文字颜色
	public var yb_titleColorForSelected: UIColor? {
		get {
			return titleColor(for: .selected)
		}
		set {
			setTitleColor(newValue, for: .selected)
		}
	}
	
	@IBInspectable
	/// disabled状态下的文字
	public var yb_titleForDisabled: String? {
		get {
			return title(for: .disabled)
		}
		set {
			setTitle(newValue, for: .disabled)
		}
	}
	
	@IBInspectable
	/// highlighted状态下的文字
	public var yb_titleForHighlighted: String? {
		get {
			return title(for: .highlighted)
		}
		set {
			setTitle(newValue, for: .highlighted)
		}
	}
	
	@IBInspectable
	/// normal 状态下的文字
	public var yb_titleForNormal: String? {
		get {
			return title(for: .normal)
		}
		set {
			setTitle(newValue, for: .normal)
		}
	}
	
	@IBInspectable
	/// selected 状态下的文字
	public var yb_titleForSelected: String? {
		get {
			return title(for: .selected)
		}
		set {
			setTitle(newValue, for: .selected)
		}
	}
    
    @IBInspectable
    /// disabled状态下的文字
    public var yb_bgImageForDisabled: UIImage? {
        get {
            return backgroundImage(for: .disabled)
        }
        set {
            setBackgroundImage(newValue, for: .disabled)
        }
    }
    
    @IBInspectable
    /// highlighted状态下的背景图片
    public var yb_bgImageForHighlighted: UIImage? {
        get {
            return backgroundImage(for: .highlighted)
        }
        set {
            setBackgroundImage(newValue, for: .highlighted)
        }
    }
    
    @IBInspectable
    /// normal 状态下的背景图片
    public var yb_bgImageForNormal: UIImage? {
        get {
            return backgroundImage(for: .normal)
        }
        set {
            setBackgroundImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable
    /// selected 状态下的背景图片
    public var yb_bgImageForSelected: UIImage? {
        get {
            return backgroundImage(for: .selected)
        }
        set {
            setBackgroundImage(newValue, for: .selected)
        }
    }
    
    /// highlighted状态下的背景图片
    public var yb_bgColorForHighlighted: UIColor {
        get {
            return UIColor()
        }
        set {
            setBackgroundImage(UIImage(tb_color: newValue, size: CGSize(width: 1, height: 1)), for: .highlighted)
        }
    }
    
    /// normal 状态下的背景图片
    public var yb_bgColorForNormal: UIColor {
        get {
            return UIColor()
        }
        set {
            setBackgroundImage(UIImage(tb_color: newValue, size: CGSize(width: 1, height: 1)), for: .normal)
        }
    }
    
    /// selected 状态下的背景图片
    public var yb_bgColorForSelected: UIColor {
        get {
            return UIColor()
        }
        set {
            setBackgroundImage(UIImage(tb_color: newValue, size: CGSize(width: 1, height: 1)), for: .selected)
        }
    }
	
    /// 设置字体大小
    public var yb_font: UIFont? {
        get {
            return titleLabel?.font
        }
        set {
            titleLabel?.font = newValue
        }
    }
}


// MARK: - 方法
public extension UIButton {
    
    private var states: [UIControlState] {
        return [.normal, .selected, .highlighted, .disabled]
    }
	
	/// 设置图片所有状态
	///
	/// - Parameter image: 需要设置的图片.
	public func yb_setImageForAllStates(_ image: UIImage) {
		states.forEach { self.setImage(image, for:  $0) }
	}
	
	/// 设置标题颜色
	///
	/// - Parameter color: UIColor.
	public func yb_setTitleColorForAllStates(_ color: UIColor) {
		states.forEach { self.setTitleColor(color, for: $0) }
	}
	
	/// 设置标题所有状态
	///
	/// - Parameter title: title string.
	public func yb_setTitleForAllStates(_ title: String) {
		states.forEach { self.setTitle(title, for: $0) }
	}
    
    /// 设置属性字体(不带下划线)
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - fontSize: 字体大小
    ///   - textColor: 字体颜色
    ///   - state: 状态
    func yb_setArrt(text: String, fontSize: CGFloat, textColor: UIColor, state: UIControlState) {
        setAttributedTitle(NSAttributedString(string: text, attributes: [NSUnderlineStyleAttributeName: 0,
                                                                         NSFontAttributeName: UIFont.systemFont(ofSize: fontSize),
                                                                         NSForegroundColorAttributeName: textColor]),
                           for: state)
    }
    
    /// 设置按钮文字颜色
    ///
    /// - Parameters:
    ///   - normal: normal 状态的颜色
    ///   - disabled: disabled 状态的颜色
    ///   - selected: selected 状态的颜色
    func yb_setTitleColor(normal: UIColor, disabled: UIColor, highlighted: UIColor?, selected: UIColor?) {
        setTitleColor(normal, for: .normal)
        setTitleColor(disabled, for: .disabled)
        setTitleColor(selected, for: .selected)
        setTitleColor(highlighted, for: .highlighted)
    }
    
    /// 设置按钮图片
    ///
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - backgroundImageName: 背景图片名称
    ///   - state: 状态
    func yb_setImage(image: String, bgImage: String, state: UIControlState) {
        setImage(UIImage(named: image), for: state)
        setBackgroundImage(UIImage(named: bgImage), for: state)
    }
    
    /// 添加事件(默认touchUpInside)
    ///
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 方法
    func yb_addTarget(_ target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }
    
}


