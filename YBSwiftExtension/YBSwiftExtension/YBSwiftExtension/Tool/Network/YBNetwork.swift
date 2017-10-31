//
//  YBNetwork.swift
//  tongFeng
//
//  Created by 王亚彬 on 2017/8/2.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// 网络请求单利
private let NetworkRequestShareInstance = YBNetwork()

class YBNetwork: NSObject {

    /// 单利
    class var sharedInstance : YBNetwork {
        return NetworkRequestShareInstance
    }
}

extension YBNetwork {
    
    /// GET请求
    ///
    /// - Parameters:
    ///   - urlString: 请求URL
    ///   - params: 请求参数
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func get(urlString: String, params : [String : Any]? = nil, success : @escaping (_ response : Any?)->(), failture : @escaping (_ error : Error)->()) {
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failture(error)
            }
        }
        
    }
    
    /// POST请求
    ///
    /// - Parameters:
    ///   - urlString: 请求URL
    ///   - params: 请求参数
    ///   - success: 成功回调
    ///   - failture: 是啊比回调
    class func post(urlString : String, params : [String : Any]? = nil, success : @escaping (_ response : Any?)->(), failture : @escaping (_ error : Error)->()) {
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                success(value)
            case .failure(let error):
                failture(error)
            }
        }
    }
    
    /// 文件上传（图片）
    ///
    /// - Parameters:
    ///   - urlString: 请求URL
    ///   - params: 请求参数
    ///   - data: 请求数据数组
    ///   - name: 数据名称
    ///   - success: 成功回调
    ///   - failture: 是啊比回调
    class func upLoadImages(urlString: String, params: [String: String]? = nil, images: [UIImage], names: [String], success : @escaping (_ response : Any?)->(), failture : @escaping (_ error : Error)->()){

        let headers = ["content-type":"multipart/form-data"]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
//                let flag = params["flag"]
//                let userId = params["userId"]
//                
//                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
//                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                for i in 0..<images.count {
                    let data = UIImageJPEGRepresentation(images[i], 1) ?? Data()
                    multipartFormData.append(data, withName: "appPhoto", fileName: names[i], mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        success(response.result.value)
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                }
            }
        )
    }
    
    /// 文件上传（图片）
    ///
    /// - Parameters:
    ///   - urlString: 请求URL
    ///   - params: 请求参数
    ///   - data: 请求数据数组
    ///   - name: 数据名称
    ///   - success: 成功回调
    ///   - failture: 是啊比回调
    class func upLoadImage(urlString: String, params: [String: String]? = nil, image: UIImage, name: String, success : @escaping (_ response : Any?)->(), failture : @escaping (_ error : Error)->()){
        upLoadImages(urlString: urlString, params: params, images: [image], names: [name], success: success, failture: failture)
    }
}
