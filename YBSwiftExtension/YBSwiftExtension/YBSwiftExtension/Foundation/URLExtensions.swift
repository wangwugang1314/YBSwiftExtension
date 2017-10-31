//
//  URLExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import Foundation


public extension URL {
	
	/// 带有附加查询参数的URL。
	///
	///		let url = URL(string: "https://google.com")!
	///		let param = ["q": "Swifter Swift"]
	///		url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
	///
	/// - Parameter parameters: parameters dictionary.
	/// - Returns: URL with appending given query parameters.
	public func yb_appendingQueryParameters(_ parameters: [String: String]) -> URL {
		var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
		var items = urlComponents.queryItems ?? []
		items += parameters.map({ URLQueryItem(name: $0, value: $1) })
		urlComponents.queryItems = items
		return urlComponents.url!
	}
	
	/// 将查询参数附加到URL。
	///
	///		var url = URL(string: "https://google.com")!
	///		let param = ["q": "Swifter Swift"]
	///		url.appendQueryParameters(params)
	///		print(url) // prints "https://google.com?q=Swifter%20Swift"
	///
	/// - Parameter parameters: parameters dictionary.
	public mutating func appendQueryParameters(_ parameters: [String: String]) {
		self = yb_appendingQueryParameters(parameters)
	}
    
    /// 构造方法创建url
    ///
    /// - Parameter urlStr: url字符串
    /// - Parameter parameters: 参数
    init?(urlStr: String, parameters: [String: String]) {
        self.init(string: urlStr)
        self = yb_appendingQueryParameters(parameters)
    }
	
}
