//
//  Requestable.swift
//  Network
//
//  Created by Muzlive_Player on 2023/12/15.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryPrameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String: String]? { get }
    var sampleData: Data? { get }
}

extension Requestable {
    func getUrlRequest() throws -> URLRequest {
        let url = try getUrl()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let bodyParameters = try bodyParameters?.toDictionary() {
            if !bodyParameters.isEmpty {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            }
        }
        
        headers?.forEach { key,value in
            urlRequest.setValue(value, forHTTPHeaderField: "\(key)")
        }
        
        return urlRequest
    }
    
    private func getUrl() throws -> URL {
        let fullPath = "\(baseURL)/\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else { throw NetworkError.common }
        
        var urlQueryItems = [URLQueryItem]()
        if let queryPrameters = try queryPrameters?.toDictionary() {
            queryPrameters.forEach { key, value in
                urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        
        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
        guard let url = urlComponents.url else { throw NetworkError.common }
        return url
    }
}

