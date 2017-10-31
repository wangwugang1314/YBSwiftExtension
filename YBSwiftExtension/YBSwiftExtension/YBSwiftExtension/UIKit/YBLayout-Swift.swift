//
//  YBLayout-Swift.swift
//
//  Created by FuYun on 2016/12/10.
//  Copyright © 2016年 FuYun. All rights reserved.
//

import UIKit
import SnapKit


/// 布局方向
///
/// - horizon: 水平
/// - vertical: 垂直
enum YBLayoutDuration {
    case horizon
    case vertical
}

/// 对齐方式
///
/// - inTop: 内部-上边
/// - inLeft: 内部-左边
/// - inBottom: 内部-底边
/// - inRight: 内部-右边
/// - outTop: 外部-上边
/// - outLeft: 外部-左边
/// - outBottom: 外部-底边
/// - outRight: 外部-右边
enum YBLayoutAlignment {
    case inTop
    case inLeft
    case inBottom
    case inRight
    case outTop
    case outLeft
    case outBottom
    case outRight
}

/// 内部布局
///
/// - leftTop: 左边-顶部
/// - leftcenter: 左边-中心
/// - leftBottom: 左边-下边
/// - centerTop: 中心-顶部
/// - centerCenter: 中心-中心
/// - centerBottom: 中心-下边
/// - rightTop: 右边-顶部
/// - rightCenter: 右边-中心
/// - rightBottom: 右边-下边
enum YBLayoutIn {
    case leftTop
    case leftcenter
    case leftBottom
    case centerTop
    case centerCenter
    case centerBottom
    case rightTop
    case rightCenter
    case rightBottom
}

/// 外部布局
///
/// - topLeft: 顶部-左边
/// - topCenter: 顶部-中心
/// - topRight: 顶部-右边
/// - bottomLeft: 底部-左边
/// - bottomCenter: 底部-中心
/// - bottomRight: 底部-右边
/// - leftTop: 左边-顶部
/// - leftCenter: 左边-中心
/// - leftBottom: 左边-底部
/// - rightTop: 右边-顶部
/// - rightCenter: 右边-中心
/// - rightBottom: 右边-底部
/// - angleLeftTop: 角-左边-顶部
/// - angleLeftBottom: 角-左边-底部
/// - angleRightTop: 角-右边-顶部
/// - angleRightBottom: 角-右边-底部
enum YBLayoutOut {
    case topLeft
    case topCenter
    case topRight
    case bottomLeft
    case bottomCenter
    case bottomRight
    case leftTop
    case leftCenter
    case leftBottom
    case rightTop
    case rightCenter
    case rightBottom
    case angleLeftTop
    case angleLeftBottom
    case angleRightTop
    case angleRightBottom
}


/// 相等布局
///
/// - width: 宽度
/// - height: 高度
/// - size: 大小
/// - centerX: 中心X
/// - centerY: 中心Y
/// - center: 中心
/// - left: 左边
/// - right: 右边
/// - top: 顶部
/// - bottom: 底部
enum YBLayoutEqual {
    case width
    case height
    case size
    case centerX
    case centerY
    case center
    case left
    case right
    case top
    case bottom
}

/// 地板砖式的平铺
///
/// - top_leftToRight: 顶部-从左到右
/// - top_rightToLeft: 顶部-从右到左
/// - bottom_leftToRight: 底部-从左到右
/// - bottom_rightToLeft: 底部-从右到左
/// - left_topToBottom: 左边-从上到下
/// - left_bottomToTop: 左边-从下到上
/// - right_topToBottom: 右边-从上到下
/// - right_bottomToTop: 右边-从下到上
enum YBLayoutTileType: Int {
    case top_leftToRight = 0
    case top_rightToLeft = 1
    case bottom_leftToRight = 2
    case bottom_rightToLeft = 3
    case left_topToBottom = 4
    case left_bottomToTop = 5
    case right_topToBottom = 6
    case right_bottomToTop = 7
}

/// 自定义间距
struct YBLayoutInteracl {
    var h: CGFloat
    var v: CGFloat
    
    init(h: CGFloat = 0, v: CGFloat = 0) {
        self.h = h
        self.v = v
    }
    
    init(interval: CGFloat) {
        self.h = interval
        self.v = interval
    }
}

/// 自定义size结构体
struct yb_layoutSize {
    var width: CGFloat?
    var height: CGFloat?
    
    init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height
    }
    
    init(size: CGFloat) {
        self.width = size
        self.height = size
    }
}

/// 自定义offset结构体
struct yb_layoutOffset {
    var horizontal: CGFloat = 0
    var vertical: CGFloat = 0
    
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    init(size: CGFloat) {
        self.horizontal = size
        self.vertical = size
    }
}


/// 自定义边距
struct yb_layoutEdgeInsets {
    var left: CGFloat = 0
    var top: CGFloat = 0
    var bottom: CGFloat = 0
    var right: CGFloat = 0
    
    init(left: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.left = left
        self.top = top
        self.bottom = bottom
        self.right = right
    }
    
    init(horizon: CGFloat, vertical: CGFloat) {
        self.left = horizon
        self.top = vertical
        self.bottom = vertical
        self.right = horizon
    }
    
    init(border: CGFloat) {
        self.left = border
        self.top = border
        self.bottom = border
        self.right = border
    }
}

extension UIView {
    
    /// 添加到父试图
    ///
    /// - Parameters:
    ///   - view: 子试图
    ///   - isAdd: 是否添加
    private func addToSuperView(view: UIView, isAdd: Bool) {
        let isAddToSuperView = view.superview
        if isAdd && isAddToSuperView != nil {
            assert(isAddToSuperView != nil, "试图已经添加到父试图，不予许重复添加")
        }else if isAdd && isAddToSuperView == nil {
            addSubview(view)
        } else {
            assert(isAddToSuperView != nil, "试图必须添加到父试图才能进行约束")
        }
    }
    
    // MARK: - 整个约束布局
    
    /// 多个子试图平铺布局
    ///
    /// - Parameters:
    ///   - views: 子试图数组
    ///   - interval: 自试图之间的间隔
    ///   - duration: 平铺方向
    ///   - edge: 子试图与俯视图的边距(默认添加)
    func yb_fill(views: [UIView], interval: CGFloat = 0, duration: YBLayoutDuration = .horizon, edge: yb_layoutEdgeInsets = yb_layoutEdgeInsets()) {
        if views.count == 1 {
            yb_fill(view: views[0], edge: edge, isAdd: true)
        } else {
            for (index, view) in views.enumerated() {
                addSubview(view)
                if duration == .horizon {
                    view.snp.makeConstraints({ (make) in
                        if index == 0 {
                            make.left.equalTo(self.snp.left).offset(edge.left)
                        } else if index == views.count - 1 {
                            make.right.equalTo(self.snp.right).offset(-edge.right)
                            make.left.equalTo(views[index - 1].snp.right).offset(interval)
                            make.width.equalTo(views.first!)
                        } else {
                            make.left.equalTo(views[index - 1].snp.right).offset(interval)
                            make.width.equalTo(views.first!)
                        }
                        make.top.equalTo(self.snp.top).offset(edge.top)
                        make.bottom.equalTo(self.snp.bottom).offset(-edge.bottom)
                    })
                }else{
                    view.snp.makeConstraints({ (make) in
                        if index == 0 {
                            make.top.equalTo(edge.top)
                        } else if index == views.count - 1 {
                            make.bottom.equalTo(-edge.bottom)
                            make.top.equalTo(views[index - 1].snp.bottom).offset(interval)
                            make.height.equalTo(views.first!)
                        } else {
                            make.top.equalTo(views[index - 1].snp.bottom).offset(interval)
                            make.height.equalTo(views.first!)
                        }
                        make.left.equalTo(self.snp.left).offset(edge.left)
                        make.right.equalTo(self.snp.right).offset(-edge.right)
                    })
                }
            }
        }
    }
    
    /// 填充(地板砖一样平铺)
    ///
    /// - Parameters:
    ///   - views: 子试图
    ///   - direction: 平铺方向
    ///   - interval: 试图之间的间隔
    ///   - sections: 分组数
    ///   - edge: 边距
    func yb_tile(views: [UIView], direction: YBLayoutTileType = .top_leftToRight, interval: YBLayoutInteracl = YBLayoutInteracl(), cellInViews: Int = 1, edge: yb_layoutEdgeInsets = yb_layoutEdgeInsets()) {
        // 需要平铺的子试图-转化成二位数组(添加自动填充的子试图)
        var allSubViews = [[UIView]]()
        for startCellIndex in stride(from: 0, to: views.count, by: cellInViews)  {
            var section = [UIView]()
            // 分组里面的view数组
            if startCellIndex + cellInViews <= views.count {
                section = (views as NSArray).subarray(with: NSRange(location: startCellIndex, length: cellInViews)) as! [UIView]
            } else {
                let chaCount = startCellIndex + cellInViews - views.count
                section = (views as NSArray).subarray(with: NSRange(location: startCellIndex, length: cellInViews - chaCount )) as! [UIView]
                for _ in 0..<chaCount {
                    section.append(UIView())
                }
            }
            allSubViews.append(section)
        }
        // 根据类型更新数据位置
        var tileViews = [[UIView]]()
        switch direction {
        case .top_leftToRight, .left_topToBottom:
            tileViews = allSubViews
        case .top_rightToLeft, .left_bottomToTop:
            for section in allSubViews {
                tileViews.append(section.reversed())
            }
        case .bottom_leftToRight, .right_topToBottom:
            tileViews = allSubViews.reversed()
        case .bottom_rightToLeft, .right_bottomToTop:
            for section in allSubViews.reversed() {
                tileViews.append(section.reversed())
            }
        }

        // 平铺试图
        if direction.rawValue <= YBLayoutTileType.bottom_rightToLeft.rawValue {
            var sectionViews = [UIView]()
            for section in tileViews {
                let sectionView = UIView()
                sectionView.yb_fill(views: section,
                                    interval: interval.h,
                                    duration: .horizon,
                                    edge: yb_layoutEdgeInsets(left: edge.left,
                                                              top: 0,
                                                              bottom: 0,
                                                              right: edge.right))
                sectionViews.append(sectionView)
            }
            yb_fill(views: sectionViews,
                    interval: interval.v,
                    duration: .vertical,
                    edge: yb_layoutEdgeInsets(left: 0, top: edge.top, bottom: edge.bottom, right: 0))
        } else {
            var sectionViews = [UIView]()
            for section in tileViews {
                let sectionView = UIView()
                sectionView.yb_fill(views: section,
                                    interval: interval.v,
                                    duration: .vertical,
                                    edge: yb_layoutEdgeInsets(left: 0,
                                                              top: edge.top,
                                                              bottom: edge.bottom,
                                                              right: 0))
                sectionViews.append(sectionView)
            }
            yb_fill(views: sectionViews,
                    interval: interval.h,
                    duration: .horizon,
                    edge: yb_layoutEdgeInsets(left: edge.left, top: 0, bottom: 0, right: edge.right))
        }
    }
    
    /// 平铺（指定Item的高度）
    ///
    /// - Parameters:
    ///   - views: 需要平铺的子试图
    ///   - itemHeight: 子试图的高度
    ///   - direction: 平铺方向
    ///   - interval: 子试图之间的间隔
    ///   - cellInViews: 一行子试图的个数
    ///   - edge: 边距(下边距是无效的)
    func yb_tile(views: [UIView], itemHeight: CGFloat, direction: YBLayoutTileType = .top_leftToRight, interval: YBLayoutInteracl = YBLayoutInteracl(), cellInViews: Int = 1, edge: yb_layoutEdgeInsets = yb_layoutEdgeInsets()) {
        // 计算行的个数
        let sectionNum = (views.count + cellInViews - 1) / cellInViews
        // 计算背景试图的高度
        var bgViewHeight: CGFloat = 0
        let sectionFloatNum: CGFloat = CGFloat(sectionNum)
        let bgView = UIView()
        var inEdit: yb_layoutEdgeInsets
        switch direction {
        case .top_leftToRight, .top_rightToLeft:
            inEdit = yb_layoutEdgeInsets(left: edge.left, top: 0, bottom: edge.bottom, right: edge.right)
            bgViewHeight = edge.bottom + itemHeight * sectionFloatNum + interval.v * (sectionFloatNum - 1)
             yb_alignment(view: bgView, duration: .inTop, width: bgViewHeight, interval: edge.top)
        case .bottom_rightToLeft, .bottom_leftToRight:
            bgViewHeight = edge.top + itemHeight * sectionFloatNum + interval.v * (sectionFloatNum - 1)
            inEdit = yb_layoutEdgeInsets(left: edge.left, top: edge.top, bottom: 0, right: edge.right)
             yb_alignment(view: bgView, duration: .inBottom, width: bgViewHeight, interval: edge.bottom)
        case .left_bottomToTop, .left_topToBottom:
            bgViewHeight = edge.right + itemHeight * sectionFloatNum + interval.h * (sectionFloatNum - 1)
            inEdit = yb_layoutEdgeInsets(left: 0, top: edge.top, bottom: edge.bottom, right: edge.right)
             yb_alignment(view: bgView, duration: .inLeft, width: bgViewHeight, interval: edge.left)
        case .right_bottomToTop, .right_topToBottom:
            bgViewHeight = edge.left + itemHeight * sectionFloatNum + interval.h * (sectionFloatNum - 1)
            inEdit = yb_layoutEdgeInsets(left: edge.left, top: edge.top, bottom: edge.bottom, right: 0)
             yb_alignment(view: bgView, duration: .inRight, width: bgViewHeight, interval: edge.right)
        }
        bgView.yb_tile(views: views, direction: direction, interval: interval, cellInViews: cellInViews, edge: inEdit)
    }
    
    /// 单个子试图平铺
    ///
    /// - Parameters:
    ///   - view: 子试图
    ///   - edge: 子试图与父试图的边距
    ///   - isAdd: 是否添加到父试图(默认添加)
    func yb_fill(view: UIView, edge: yb_layoutEdgeInsets = yb_layoutEdgeInsets(), isAdd: Bool = true) {
        addToSuperView(view: view, isAdd: isAdd)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: edge.top, left: edge.left, bottom: edge.bottom, right: edge.right))
        }
    }

    
    /// 对齐布局(self: 参照试图)
    ///
    /// - Parameters:
    ///   - view: 需要布局的试图
    ///   - duration: 参照方向
    ///   - width: 需要布局试图的宽度
    ///   - interval: 布局试图与参照试图的间隔
    ///   - sideInterval: 布局试图与参照试图的边距
    ///   - isAdd: 是否添加到参照试图上(默认添加)
    func yb_alignment(view: UIView, duration: YBLayoutAlignment, width: CGFloat? = nil, interval: CGFloat = 0, sideInterval: CGFloat = 0, isAdd: Bool = true) {
        addToSuperView(view: view, isAdd: isAdd)
        switch duration {
        case .inTop:
            view.snp.makeConstraints({ (make) in
                make.top.equalTo(self.snp.top).offset(interval)
                if let width = width {
                    make.height.equalTo(width)
                }
                make.left.equalTo(self.snp.left).offset(sideInterval)
                make.right.equalTo(self.snp.right).offset(-sideInterval)
            })
        case .inLeft:
            view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(interval)
                if let width = width {
                    make.width.equalTo(width)
                }
                make.top.equalTo(self.snp.top).offset(sideInterval)
                make.bottom.equalTo(self.snp.bottom).offset(-sideInterval)
            })
        case .inRight:
            view.snp.makeConstraints({ (make) in
                make.right.equalTo(self.snp.right).offset(-interval)
                if let width = width {
                    make.width.equalTo(width)
                }
                make.top.equalTo(self.snp.top).offset(sideInterval)
                make.bottom.equalTo(self.snp.bottom).offset(-sideInterval)
            })
        case .inBottom:
            view.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.snp.bottom).offset(-interval)
                if let width = width {
                    make.height.equalTo(width)
                }
                make.left.equalTo(self.snp.left).offset(sideInterval)
                make.right.equalTo(self.snp.right).offset(-sideInterval)
            })
        case .outTop:
            view.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.snp.top).offset(-interval)
                if let width = width {
                    make.height.equalTo(width)
                }
                make.left.equalTo(self.snp.left).offset(sideInterval)
                make.right.equalTo(self.snp.right).offset(-sideInterval)
            })
        case .outLeft:
            view.snp.makeConstraints({ (make) in
                make.right.equalTo(self.snp.left).offset(-interval)
                if let width = width {
                    make.width.equalTo(width)
                }
                make.top.equalTo(self.snp.top).offset(sideInterval)
                make.bottom.equalTo(self.snp.bottom).offset(-sideInterval)
            })
        case .outRight:
            view.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.right).offset(interval)
                if let width = width {
                    make.width.equalTo(width)
                }
                make.top.equalTo(self.snp.top).offset(sideInterval)
                make.bottom.equalTo(self.snp.bottom).offset(-sideInterval)
            })
        case .outBottom:
            view.snp.makeConstraints({ (make) in
                make.top.equalTo(self.snp.bottom).offset(interval)
                if let width = width {
                    make.height.equalTo(width)
                }
                make.left.equalTo(self.snp.left).offset(sideInterval)
                make.right.equalTo(self.snp.right).offset(-sideInterval)
            })
        }
    }
    
    
    /// 中心布局
    ///
    /// - Parameters:
    ///   - view: 需要布局的试图
    ///   - size: 需要布局试图的大小
    ///   - offset: 需要布局试图的偏移
    ///   - isAdd: 是否添加到参照试图(默认添加)
    func yb_center(view: UIView, size: yb_layoutSize? = nil, offset: yb_layoutOffset = yb_layoutOffset(), isAdd: Bool = true) {
        addToSuperView(view: view, isAdd: isAdd)
        view.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX).offset(offset.horizontal)
            make.centerY.equalTo(snp.centerY).offset(offset.vertical)
        }
        // 设置大小
        view.yb_setSize(size: size)
    }
    
    
    /// 内部布局
    ///
    /// - Parameters:
    ///   - view: 需要布局的试图
    ///   - duration: 布局方向
    ///   - size: 需要布局试图的大小
    ///   - offset: 需要布局试图的偏移
    ///   - isAdd: 是否添加到参照试图(默认添加)
    func yb_in(view: UIView, duration: YBLayoutIn, size: yb_layoutSize? = nil, offset: yb_layoutOffset = yb_layoutOffset(), isAdd: Bool = true) {
        addToSuperView(view: view, isAdd: isAdd)
        view.snp.makeConstraints { (make) in
            switch duration {
                case .leftTop:
                    make.left.equalTo(snp.left).offset(offset.horizontal)
                    make.top.equalTo(snp.top).offset(offset.vertical)
                case .leftcenter:
                    make.left.equalTo(snp.left).offset(offset.horizontal)
                    make.centerY.equalTo(snp.centerY).offset(offset.vertical)
                case .leftBottom:
                    make.left.equalTo(snp.left).offset(offset.horizontal)
                    make.bottom.equalTo(snp.bottom).offset(offset.vertical)
                case .centerTop:
                    make.centerX.equalTo(snp.centerX).offset(offset.horizontal)
                    make.top.equalTo(snp.top).offset(offset.vertical)
                case .centerCenter:
                    make.centerX.equalTo(snp.centerX).offset(offset.horizontal)
                    make.centerY.equalTo(snp.centerY).offset(offset.vertical)
                case .centerBottom:
                    make.centerX.equalTo(snp.centerX).offset(offset.horizontal)
                    make.bottom.equalTo(snp.bottom).offset(offset.vertical)
                case .rightTop:
                    make.right.equalTo(snp.right).offset(offset.horizontal)
                    make.top.equalTo(snp.top).offset(offset.vertical)
                case .rightCenter:
                    make.right.equalTo(snp.right).offset(offset.horizontal)
                    make.centerY.equalTo(snp.centerY).offset(offset.vertical)
                case .rightBottom:
                    make.right.equalTo(snp.right).offset(offset.horizontal)
                    make.bottom.equalTo(snp.bottom).offset(offset.vertical)
            }
        }
        // 设置大小
        view.yb_setSize(size: size)
    }
    
    
    /// 外部布局
    ///
    /// - Parameters:
    ///   - view: 需要布局的子试图
    ///   - duration: 布局方向
    ///   - size: 需要布局试图的大小
    ///   - offset: 偏移量
    ///   - isAdd: 是否添加到参照试图(默认不添加)
    func yb_out(view: UIView, duration: YBLayoutOut, size: yb_layoutSize? = nil, offset: yb_layoutOffset = yb_layoutOffset(), isAdd: Bool = false) {
        addToSuperView(view: view, isAdd: isAdd)
        view.snp.makeConstraints { (make) in
            switch duration {
                case .angleLeftTop:
                    make.right.equalTo(snp.left).offset(offset.horizontal)
                    make.bottom.equalTo(snp.top).offset(offset.vertical)
                case .angleRightTop:
                    make.left.equalTo(snp.right).offset(offset.horizontal)
                    make.bottom.equalTo(snp.top).offset(offset.vertical)
                case .angleLeftBottom:
                    make.right.equalTo(snp.left).offset(offset.horizontal)
                    make.top.equalTo(snp.bottom).offset(offset.vertical)
                case .angleRightBottom:
                    make.left.equalTo(snp.right).offset(offset.horizontal)
                    make.top.equalTo(snp.bottom).offset(offset.vertical)
                case .topLeft:
                    make.bottom.equalTo(snp.top).offset(offset.vertical)
                    make.left.equalTo(snp.left).offset(offset.horizontal)
                case .topCenter:
                    make.bottom.equalTo(snp.top).offset(offset.vertical)
                    make.centerX.equalTo(snp.centerX).offset(offset.horizontal)
                case .topRight:
                    make.bottom.equalTo(snp.top).offset(offset.vertical)
                    make.right.equalTo(snp.right).offset(offset.horizontal)
                case .leftTop:
                    make.right.equalTo(snp.left).offset(offset.horizontal)
                    make.top.equalTo(snp.top).offset(offset.vertical)
                case .leftCenter:
                    make.right.equalTo(snp.left).offset(offset.horizontal)
                    make.centerY.equalTo(snp.centerY).offset(offset.vertical)
                case .leftBottom:
                    make.right.equalTo(snp.left).offset(offset.horizontal)
                    make.bottom.equalTo(snp.bottom).offset(offset.vertical)
                case .rightTop:
                    make.left.equalTo(snp.right).offset(offset.horizontal)
                    make.top.equalTo(snp.top).offset(offset.vertical)
                case .rightCenter:
                    make.left.equalTo(snp.right).offset(offset.horizontal)
                    make.centerY.equalTo(snp.centerY).offset(offset.vertical)
                case .rightBottom:
                    make.left.equalTo(snp.right).offset(offset.horizontal)
                    make.bottom.equalTo(snp.bottom).offset(offset.vertical)
                case .bottomLeft:
                    make.top.equalTo(snp.bottom).offset(offset.vertical)
                    make.left.equalTo(snp.left).offset(offset.horizontal)
                case .bottomCenter:
                    make.top.equalTo(snp.bottom).offset(offset.vertical)
                    make.centerX.equalTo(snp.centerX).offset(offset.horizontal)
                case .bottomRight:
                    make.top.equalTo(snp.bottom).offset(offset.vertical)
                    make.right.equalTo(snp.right).offset(offset.horizontal)
            }
        }
        // 设置大小
        view.yb_setSize(size: size)
    }
    
    // MARK: - 部分约束布局
    
    /// 相等布局（self: 参照的试图 不一定是父试图, 需要手动添加到父试图）所有试图都与 self 进行设置
    ///
    /// - Parameters:
    ///   - views: 需要布局的试图
    ///   - duration: 布局方向
    func yb_equal(views: [UIView], duration: YBLayoutEqual) {
        // 判断试图是否添加到父试图
        guard superview != nil else {
            assert(false, "self 必须添加到父试图, 才可以使用布局")
        }
        for itemView in views {
            guard itemView.superview != nil else {
                assert(false, "需要布局的试图 必须添加到父试图, 才可以使用布局")
            }
            itemView.snp.makeConstraints({ (make) in
                switch duration {
                case .width:
                    make.width.equalTo(self)
                case .height:
                    make.height.equalTo(self)
                case .size:
                    make.width.equalTo(self)
                    make.height.equalTo(self)
                case .centerX:
                    make.centerX.equalTo(self)
                case .centerY:
                    make.centerY.equalTo(self)
                case .center:
                    make.centerX.equalTo(self)
                    make.centerY.equalTo(self)
                case .top:
                    make.top.equalTo(self)
                case .left:
                    make.left.equalTo(self)
                case .right:
                    make.right.equalTo(self)
                case .bottom:
                    make.bottom.equalTo(self)
                }
            })
        }
    }
    
    
    /// 相等大小布局（具体等于某个值）
    ///
    /// - Parameters:
    ///   - views: 需要布局的试图
    ///   - duration: 布局方向
    class func yb_equalSize(views: [UIView], size: yb_layoutSize) {
        for itemView in views {
            itemView.yb_setSize(size: size)
        }
    }
    
    /// 设置试图大小(如果传的值小于0 就不会设置)
    ///
    /// - Parameter size: 试图大小
    func yb_setSize(size: yb_layoutSize?) {
        guard let superView = superview else {
            assert(false, "需要布局的试图 必须添加到父试图, 才可以使用布局")
            return
        }
        snp.makeConstraints { (make) in
            if let width = size?.width {
                if width >= 0 {
                    make.width.equalTo(width)
                } else {
                    make.width.equalTo(superView).offset(width)
                }
            }
            if let height = size?.height {
                if height >= 0 {
                    make.height.equalTo(height)
                } else {
                    make.height.equalTo(superView).offset(height)
                }
            }
        }
    }
    
    /// 父试图高度根据子试图大小设定(父试图必须有高度约束,snp更新的时候回报错)
    ///
    /// - Parameters:
    ///   - bottomView: 底部的子试图
    ///   - bottomMargin: 底部的边距
    func yb_autoHeight(bottomSubView bottomView: UIView, bottomMargin: CGFloat) {
        guard bottomView.superview == self else {
            assert(false, "底部试图必须是其直接子试图")
            return
        }
        layoutIfNeeded()
        snp.updateConstraints { (make) in
            make.height.equalTo(bottomView.frame.maxY + bottomMargin)
        }
    }
    
    /// 父试图宽度根据子试图大小设定(父试图必须有宽度约束,snp更新的时候回报错)
    ///
    /// - Parameters:
    ///   - bottomView: 底部的子试图
    ///   - bottomMargin: 底部的边距
    func yb_autoWidth(rightSubView rightView: UIView, rightMargin: CGFloat) {
        guard rightView.superview == self else {
            assert(false, "底部试图必须是其直接子试图")
            return
        }
        layoutIfNeeded()
        snp.updateConstraints { (make) in
            make.width.equalTo(rightView.frame.maxX + rightMargin)
        }
    }
}

// MARK: - scrollView自定义congtSize大小
// 必须所有子试图全部添加上去
// 当有label这样的试图的时候必须是设置好的数据，这样才会自动设置大小
extension UIScrollView {
    
    /// 根据子试图自定义父试图高度
    ///
    /// - Parameters:
    ///   - bottomView: 最底部的试图
    ///   - bottomMargin: 最底部的边距
    func yb_setupAutoContentSize(bottomView: UIView, bottomMargin: CGFloat) {
        guard bottomView.superview == self else {
            assert(false, "底部试图必须添加到scrollView上面")
            return
        }
        layoutIfNeeded()
        contentSize = CGSize(width: frame.size.width, height: bottomView.frame.maxY + bottomMargin)
    }
    
    /// 根据子试图自定义父试图高度
    ///
    /// - Parameters:
    ///   - rightView: 最右边的试图
    ///   - rightMargin: 最右边的边距
    func yb_setupAutoContentSize(rightView: UIView, rightMargin: CGFloat) {
        guard rightView.superview == self else {
            assert(false, "底部试图必须添加到scrollView上面")
            return
        }
        layoutIfNeeded()
        contentSize = CGSize(width: rightView.frame.maxX + rightMargin, height: frame.size.height)
    }
}

/// tableView cell高度自适应
/// 布局的时候需要从上到下依次布局、不能依据contentView的底部进行布局
/// 如果需要更新cell的高度，在更新前首先需要清除模型中的cell高度
class YBAotoCellModel: NSObject {
    var str = ""
    // MARK: - 属性
    /// 内部自定义的高度（用来缓存高度）
    private var _cellHeight: CGFloat = 0
    
    // MARK: - 方法 必须写到 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 最下面
    func yb_countCellHeight(cell: UITableViewCell, bottomView: UIView, bottomMargin: CGFloat) {
        // 如果有缓存数据直接返回缓存数据
        if _cellHeight > 0 {
            return
        }
        cell.contentView.layoutIfNeeded()
        _cellHeight = bottomView.frame.maxY + bottomMargin
    }
    
    /// 更新cell高度(reloadData之前需要先将模型中的数据清除)
    func yb_reloadCellHeight() {
        _cellHeight = 0
    }
    
    /// 获取cell高度
    func yb_cellHeight() -> CGFloat {
        return _cellHeight
    }
}


/// 设置图片背景试图（当前试图必须使用约束左上角布局，并且需要指定大小）
/// 省去collectionView, collectionView性能低
class YBPhotosBgView: UIView {
    
    // MARK: - 属性
    fileprivate var imageClick: ((Int, [String]) -> ())?
    fileprivate var itemWidth: CGFloat = 0
    fileprivate var interval: CGFloat = 0
    fileprivate var pics = [String]()
    
    // MARK: - 构造方法
    init(itemWidth: CGFloat, interval: CGFloat, imageClick: @escaping (Int, [String]) -> ()) {
        super.init(frame: CGRect())
        self.imageClick = imageClick
        self.itemWidth = itemWidth
        self.interval = interval
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置图片背景试图
    func setImages(pics: [String], oneSize: CGSize? = nil) {
        self.pics = pics
        for subView in subviews {
            subView.removeFromSuperview()
        }
        guard pics.count > 0 else {
            snp.updateConstraints { (make) in
                make.size.equalTo(CGSize())
            }
            return
        }
        var imageViews = [UIImageView]()
        for index in 0..<pics.count {
            let imageView = UIImageView(contentMode: .scaleAspectFill)
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageClick(tapGestureRecognizer:))))
            imageView.tag = index
            imageView.clipsToBounds = true
            imageView.yb_kf(urlStr: pics[index])
            imageViews.append(imageView)
        }
        // 根据高度设置父试图的高度
        var width: CGFloat = 0
        var height: CGFloat = 0
        var cellInViews = 3
        switch pics.count {
        case 1:
            cellInViews = 1
            if let oneSize = oneSize {
                width = oneSize.width
                height = oneSize.height
            } else {
                width = itemWidth
                height = itemWidth
            }
        case 2, 3:
            width = itemWidth * CGFloat(pics.count) + CGFloat(pics.count - 1) * interval
            height = itemWidth
            cellInViews = pics.count
        case 4:
            width = itemWidth * 2 + interval
            height = itemWidth * 2
            cellInViews = 2
        case 5...6:
            width = itemWidth * 3 + interval * 2
            height = itemWidth * 2
            cellInViews = 3
        default:
            width = itemWidth * 3 + interval * 2
            height = itemWidth * 3
            cellInViews = 3
        }
        snp.updateConstraints { (make) in
            make.size.equalTo(CGSize(width: width, height: height))
        }
        yb_tile(views: imageViews,
                direction: .top_leftToRight,
                interval: YBLayoutInteracl(interval: interval),
                cellInViews: cellInViews,
                edge: yb_layoutEdgeInsets(left: 0, top: 0, bottom: 0, right: 0))
    }
    
    /// 图片点击
    @objc fileprivate func imageClick(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let imageView = tapGestureRecognizer.view else {
            return
        }
        imageClick?(imageView.tag, pics)
    }
}






