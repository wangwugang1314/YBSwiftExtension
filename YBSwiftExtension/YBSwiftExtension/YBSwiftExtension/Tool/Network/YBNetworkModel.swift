//
//  YBNetwork Model.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/8/16.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit
import SwiftyJSON

enum YBUrls: String {
    // 用户注册
    case register = "User/regUser"
    // 更新用户信息
    case reloadUserData = "User/modifyInfo"
    // 发送验证码
    case sendCode = "User/sendCode"
    // 绑定手机
    case bindPhone = "User/setPhone"
    // 用户档案设置
    case setUserProfile = "User/setProfile"
    // 用户反馈
    case feedback = "User/userFeedback"
    // 上传单张图片
    case updataImage = "Common/upload"
    // 获取图表的列表数据
    case chartListData = "Action/actionList"
    // 图表统计
    case chartAnalysis = "Action/analysis"
    // 添加记录
    case addRecord = "Action/add"
    // 最新一条记录
    case newRecord = "Action/getLastDetail"
    // 获取资讯列表
    case newsList = "News/index"
    // 资讯详情
    case newsDetail = "News/detail"
    // 资讯收藏
    case newsCollection = "Common/collect"
    // 资讯评论列表
    case newsCommentList = "News/commentList"
    // 我的收藏
    case myCollection = "User/collectNews"
    // 问答列表
    case quextionList = "Question/index"
    // 问答详情
    case quesyionDetil = "Question/detail"
    // 评论列表
    case questionCommentList = "Question/commentList"
    // 回答问题
    case questionAnswer = "Question/addAnwser"
    // 提问
    case questionAdd = "Question/addQuestion"
    // 关注问题
    case questionFocus = "Question/followQuestion"
    // 评论点赞
    case commentsThumb = "Common/commentLike"
    // 添加评论
    case addComments = "Common/addComment"
    // 我的关注
    case myFocus = "User/myFollow"
    // 我的提问
    case myQuestion = "User/myQuestion"
    // 我的回答
    case myAnswer = "User/myAnswer"
    // 我的消息
    case myMessage = "User/message"
    // 修改消息状态
    case changeMsgStatus = "User/changeMsgStatus"
    // 未读消息数量
    case newMessageNum = "User/newMessage"
    // 获取药品列表
    case grugList = "Medicine/index"
    // 获取药品详情
    case grugDetil = "Medicine/detail"
    // 尿常规自动检测接口
    case niaoChangGuiAuto = "UrineAnalysis/testPaper"
    // 获取尿检记录
    case niaoChangGuiDetil = "UrineAnalysis/detail"
    // 删除记录
    case removeRecord = "Action/del"
    // 获取记录详情
    case recordDetil = "Action/detail"
    // 定位
    case getLocationName = "Common/location"
    // 专家列表
    case expertList = "Expert/expert_list"
    // 认证信息
    case expertInfo = "Expert/expertInfo"
    // 修改个人数据
    case updateUserInfo = "Expert/updateInfo"
    // 专家角色变更
    case exportAdd = "Expert/add"
    // 城市列表
    case cityList = "Expert/cityList"
    
    // 获取疯友圈列表
    case friendList = "Album/index"
    
    // 喜欢按钮点击
    case commonLike = "Common/like"
}


class YBNetworkModel: NSObject {
    
    /// 测试手机号
    private static let phone = "17620747824"
    /// 全局的url
    private static let globalUrl = "https://www.meirong8.com/Gout/api.php?s=/"
    
    // MARK: - 网络请求
    class func login(finish: @escaping (String?) -> ()) {
        let property = ["phone": YBNetworkModel.phone]
        GET(url: .register, property: property) { (data, error) in
            if let error = error {
                finish(error)
            } else {
                // 设置用户数据
                YBUserModel.setData(data: data)
                finish(nil)
            }
        }
    }
    
    // MARK: - 总的网络请求
    class func GET(url: YBUrls, property: [String: Any]? = nil, finish: @escaping (JSON?, String?) -> ()) {
        let netUrl = YBNetworkModel.globalUrl + url.rawValue
        YBGlobal.print("==================== URL =====================")
        YBGlobal.print(netUrl)
        YBGlobal.print("==================== Property =====================")
        let userModel = YBUserModel.shared
        var p = [String: Any]()
        if let uid = userModel.uid, let token = userModel.token {
            p["uid"] = uid
            p["token"] = token
        }
        if let property = property {
            for (k, v) in property {
                p[k] = v
            }
        }
        YBGlobal.print(p)
        YBNetwork.get(urlString: netUrl, params: p, success: { (data) in
            YBGlobal.print("==================== data =====================")
            YBGlobal.print(data ?? "")
            // 获取数据
            let jsonData = JSON(data ?? "")
            // 获取code
            let code = jsonData["code"].int
            if (code == 0) {
                finish(jsonData["data"], nil)
            } else {
                finish(nil, jsonData["errorMsg"].string)
                YBHUD.show(type: .error, title: "\(code ?? 1314)")
            }
        }) { (error) in
            YBGlobal.print("==================== error =====================")
            YBGlobal.print(error)
            finish(nil, "网络错误")
            YBHUD.show(type: .error, title: "404")
        }
    }
}
