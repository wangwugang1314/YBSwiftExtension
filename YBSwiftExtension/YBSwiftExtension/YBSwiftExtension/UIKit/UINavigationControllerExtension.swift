//
//  UINavigationControllerExtension.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/9/5.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// push 控制器 默认动画
    ///
    /// - Parameter vc: 需要push的控制器
    func yb_pushViewController(_ vc: UIViewController) {
        pushViewController(vc, animated: true)
    }
    
    /// popViewController
    func yb_popViewController() {
        popViewController(animated: true)
    }
    
    /// pop + 完成调用
    ///
    /// - Parameter completion: 完成回调 (default is nil).
    public func yb_popViewController(_ completion: (()->Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    /// push + 完成调用
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: 完成调用 (default is nil).
    public func yb_push(viewController: UIViewController, completion: (()->Void)? = nil)  {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    /// 改变导航栏颜色
    ///
    /// - Parameter tint: tint color (default is .white).
    public func yb_makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: tint]
    }
}
