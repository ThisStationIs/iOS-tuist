//
//  RequestResponsable.swift
//  Network
//
//  Created by Muzlive_Player on 2023/12/15.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

public protocol RequestResponsable: Requestable, Responsable {}

public class Endpoint<R>: RequestResponsable {
    public typealias Response = R
    
    public var baseURL: String
    public var path: String
    public var method: HttpMethod
    
    public var queryPrameters: Encodable?
    public var bodyParameters: Encodable?
    public var headers: [String : String]?
    public var sampleData: Data?
    
    public init(
        baseURL: String =
        "http://ec2-3-37-127-228.ap-northeast-2.compute.amazonaws.com",
        path: String = "",
        method: HttpMethod = .get,
        queryPrameters: Encodable? = nil,
        bodyParameters: Encodable? = nil,
        headers: [String: String]? = [:],
        sampleData: Data? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryPrameters = queryPrameters
        self.bodyParameters = bodyParameters
        self.headers = headers
        self.sampleData = sampleData
    }
}
