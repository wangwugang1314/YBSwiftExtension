//
//  UIStoryboardExtensions.swift
//  SwifterSwift
//
//  Created by Steven on 2/6/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - Methods
public extension UIStoryboard {
    
    /// 获取主 Storyboard
    public static var yb_mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    /// 使用名称实例化一个控制器
    ///
    /// - Parameter name: UIViewController type
    /// - Returns: The view controller corresponding to specified class name
    public func yb_instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: name)) as! T
    }
}
#endif
