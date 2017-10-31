//
//  YBLoadListDataModel.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/8/25.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 列表加载类型
///
/// - initial: 初始化
/// - new: 新数据
/// - old: 老数据
enum YBListLoadType {
    case new
    case old
}

/// 加载数据类型
///
/// - loding: 正在加载数据
/// - error: 加载错误（网络错误）
/// - none: 加载数据为空
/// - success: 加载成功（有数据）
enum YBListLoadFinishType {
    case loding
    case error
    case none
    case success
}

/// 列表模型的协议
protocol YBListModelProtocol {
    
    /// 构造方法（通过JSON返回一个对象）
    ///
    /// - Parameter json: JSON对象
    init(json: JSON)
}

/// 最基础的列表数据模型
class YBListModel: YBListModelProtocol {
    
    var json: JSON
    
    required init(json: JSON) {
        self.json = json
    }
}

/// 加载列表数据的协议
protocol YBLoadListDataProtocol: NSObjectProtocol {
    
    /// 定义类型别名
    associatedtype ModelType: YBListModelProtocol
    
    // MARK: - 属性
    /// 数组模型
    var dataArr:[ModelType] {get set}
    
    /// 页码
    var page: Int {get set}
    
    /// 是否正在加载数据
    var isLoading: Bool {get set}
    
    /// 需要请求数据的url
    var url: YBUrls {get set}
    
    /// 请求数据的额外参数
    var property: [String: Any] {get set}
    
    // MARK: - 方法
    /// 加载网络数据
    func loadListData(loadType: YBListLoadType, finish: @escaping (YBListLoadFinishType) -> ())
}

// MARK: - 协议的默认实现
extension YBLoadListDataProtocol {
    
    /// 加载网络数据
    func loadListData(loadType: YBListLoadType, finish: @escaping (YBListLoadFinishType) -> ()) {
        // 如果加载数据直接返回
        guard isLoading == false else {
            finish(.loding)
            return
        }
        // 标记正在加载数据
        isLoading = true
        // 设置当前加载的页数
        var page = 1
        if loadType == .old {
            page = self.page
        }
        // 设置加载参数
        var property: [String: Any] = ["page": page, "count": 20]
        for (k, v) in self.property {
            property[k] = v
        }
        YBNetworkModel.GET(url: url, property: property) {[weak self] (data, error) in
            guard let weakSelf = self else {
                return
            }
            // 标记已经加载到数据
            weakSelf.isLoading = false
            guard error == nil else {
                finish(.error)
                return
            }
            guard let data = data, let dataArr = data.array else {
                finish(.none)
                return
            }
            var modelArr = [ModelType]()
            for item in dataArr {
                let model = ModelType(json: item)
                modelArr.append(model)
            }
            switch loadType {
            case .new:
                weakSelf.dataArr = modelArr
                weakSelf.page = 2
            case .old:
                weakSelf.page += 1
                weakSelf.dataArr += modelArr
            }
            finish(.success)
        }
    }
}
