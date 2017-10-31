//
//  UITextFieldExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - Enums
public extension UITextField {
	
	/// UITextField 文字类型.
	///
	/// - emailAddress: UITextField 用于输入电子邮件地址.
	/// - password: UITextField 密码.
	/// - generic: UITextField 用于输入泛型文本.
	public enum TextType {
		case emailAddress
		case password
		case generic
	}
	
}
	
	
// MARK: - Properties
public extension UITextField {
	
	/// 为常见文本设置类型
	public var yb_textType: TextType {
		get {
			if keyboardType == .emailAddress {
				return .emailAddress
			} else if isSecureTextEntry {
				return .password
			}
			return .generic
		}
		set {
			switch newValue {
			case .emailAddress:
				keyboardType = .emailAddress
				autocorrectionType = .no
				autocapitalizationType = .none
				isSecureTextEntry = false
				placeholder = "Email Address"
				
			case .password:
				keyboardType = .asciiCapable
				autocorrectionType = .no
				autocapitalizationType = .none
				isSecureTextEntry = true
				placeholder = "Password"
				
			case .generic:
				isSecureTextEntry = false
				
			}
		}
	}
	
	
	/// 判断是否为空
	public var yb_isEmpty: Bool {
		return text?.isEmpty == true
	}
	
	/// SwifterSwift: Return text with no spaces or new lines in beginning and end.
	public var trimmedText: String? {
		return text?.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	/// 检查是否是有效的电子邮件格式
	///
	///		textField.text = "john@doe.com"
	///		textField.hasValidEmail -> true
	///
	///		textField.text = "swifterswift"
	///		textField.hasValidEmail -> false
	///
	public var yb_hasValidEmail: Bool {
		// http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
		return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
		                   options: String.CompareOptions.regularExpression,
		                   range: nil, locale: nil) != nil
	}
	
	@IBInspectable
	/// 左视图颜色
	public var yb_leftViewTintColor: UIColor? {
		get {
			guard let iconView = leftView as? UIImageView else {
				return nil
			}
			return iconView.tintColor
		}
		set {
			guard let iconView = leftView as? UIImageView else {
				return
			}
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}

	@IBInspectable
	/// 右试图颜色
	public var yb_rightViewTintColor: UIColor? {
		get {
			guard let iconView = rightView as? UIImageView else {
				return nil
			}
			return iconView.tintColor
		}
		set {
			guard let iconView = rightView as? UIImageView else {
				return
			}
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}

}

// MARK: - Methods
public extension UITextField {
	
	/// 清除文本
	public func yb_clear() {
		text = ""
		attributedText = NSAttributedString(string: "")
	}
	
	/// 设置站位文本颜色
	///
	/// - Parameter color: placeholder text color.
	public func yb_setPlaceHolderTextColor(_ color: UIColor) {
		guard let holder = placeholder, !holder.isEmpty else {
			return
		}
		self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [NSForegroundColorAttributeName: color])
	}
  
    /// 添加左边编剧
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    public func yb_addPaddingLeft(_ padding: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
    leftView = paddingView
    leftViewMode = .always
    }
    
    /// 添加左边图片，边距
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.leftView = imageView
        self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextFieldViewMode.always
    }
}

// MARK: - 限制输入
public extension UITextField  {
    
    /// 限制字符串输入(只允许输入数字并且制定输入大小)
    ///
    /// - Parameters:
    ///   - range: 代理返回的range
    ///   - replacementString: 代理返回的数据
    ///   - maxNum: 允许输入的最大数字
    public func yb_isNum(range: NSRange, replacementString string: String, maxNum: Int) -> Bool {
        // 判断字符串长度
        if string.characters.count == 1 { // 输入的数据
            guard let character = string.characters.first else {
                return false
            }
            if (character >= "0" && character <= "9") { // 数据格式正确
                if let text = text {
                    if text.characters.count == 0 && character == "0" { // 第一个数字不能是0
                        return false
                    } else {
                        let str = (text as NSString).replacingCharacters(in: range, with: string)
                        let num = Int(str) ?? 0
                        return num <= maxNum
                    }
                } else {
                    return true
                }
            } else { // 数据格式不正确
                return false
            }
        } else if string.characters.count > 1 { // 拷贝的数据
            return false
        } else { // 删除的数据
            return true
        }
    }
    
    /// 限制字符串输入(只允许输入数字并且制定输入大小)可以有小数点
    ///
    /// - Parameters:
    ///   - range: 代理返回的range
    ///   - string: 代理返回的数据
    ///   - maxNum: 允许输入的最大数字
    ///   - deep: 小数点长度
    /// - Returns: 返回是否允许输入
    public func yb_isNum(range: NSRange, replacementString string: String, maxNum: Float, deep: Int) -> Bool {
        // 判断字符串长度
        if string.characters.count == 1 { // 输入的数据
            guard let character = string.characters.first else {
                return false
            }
            if ((character >= "0" && character <= "9") || character == ".") { // 数据格式正确
                if let text = text {
                    if text.characters.count == 0 && (character == "0" || character == ".") { // 第一个数字不能是 0 或者 .
                        return false
                    } else {
                        let dianRange = (text as NSString).range(of: ".")
                        // 已经存在小数点，并且当前是小数点直接返回
                        if dianRange.length > 0 && character == "." {
                            return false
                        }
                        if dianRange.length > 0 {
                            // 获取小数点的深度
                            let dianLength = text.characters.count - 1 - dianRange.location
                            // 首先判断当前的位置是否是小数点后面的位置
                            if range.location > dianRange.location {
                                // 判断小数点后面的位数是否超出
                                if dianLength + 1 > deep { // 小数点位数超出
                                    return false
                                }
                            }
                        }
                        // 判断数值是否超出
                        let str = (text as NSString).replacingCharacters(in: range, with: string)
                        let num = Float(str) ?? 0
                        return num <= maxNum
                    }
                } else {
                    return true
                }
            } else { // 数据格式不正确
                return false
            }
        } else if string.characters.count > 1 { // 拷贝的数据
            return false
        } else { // 删除的数据
            return true
        }
    }
    
    /// 不允许输入的字符
    ///
    /// - Parameters:
    ///   - characters: 不允许输入的字符数组
    ///   - range: 输入的范围
    ///   - string: 输入额字符串
    /// - Returns: 返回是否允许输入
    func yb_dontAllow(characters: [String], range: NSRange, replacementString string: String) -> Bool {
        // 判断字符串长度
        if string.characters.count == 1 { // 输入的数据
            return !characters.contains(string)
        } else if string.characters.count > 1 { // 拷贝的数据
            return false
        } else { // 删除的数据
            return true
        }
    }
    
    /// 允许输入的字符
    ///
    /// - Parameters:
    ///   - characters: 允许输入的字符数组
    ///   - range: 输入的范围
    ///   - string: 输入额字符串
    /// - Returns: 返回是否允许输入
    func yb_allow(characters: [String], range: NSRange, replacementString string: String) -> Bool {
        // 判断字符串长度
        if string.characters.count == 1 { // 输入的数据
            return characters.contains(string)
        } else if string.characters.count > 1 { // 拷贝的数据
            return false
        } else { // 删除的数据
            return true
        }
    }
}
