//
//  UITableViewCellExtension.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/9/7.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit

extension UITableViewCell {

    /// tableViewCell创建分割线
    ///
    /// - Parameters:
    ///   - lineWidth: 线宽
    ///   - lineColor: 线颜色
    ///   - leftInterval: 左边边距
    ///   - rightInterval: 右边边距
    /// - Returns: 返回分割线
    func yb_separator(lineWidth: CGFloat, lineColor: UIColor, leftInterval: CGFloat = 0, rightInterval: CGFloat = 0) -> UIView {
        let lineView = UIView()
        lineView.backgroundColor = lineColor
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(leftInterval)
            make.right.equalTo(self.snp.right).offset(-rightInterval)
            make.height.equalTo(lineWidth)
            make.bottom.equalTo(self)
        }
        return lineView
    }
}


