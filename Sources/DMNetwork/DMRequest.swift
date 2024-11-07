//
//  DMURLRequest.swift
//  DMNetwork
//
//  Created by Dylan  on 11/4/24.
//

import Foundation

/// HTTP Method for the request.
public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

/// Defines a URLRequest object. This request sets default values (same as Apple's) for
/// cachePolicy and timeoutInterval. You can update these values to work with your requirements.
public protocol DMRequest: DMEndpoint {
    /// The HTTP Method for this request. Available values are:
    /// `.put`, `.post`, `.get`, `.delete`.
    var method: HTTPMethod { get }
    /// Cache policy for the request. Default value is: `.useProtocolCachePolicy`,
    /// which is Apple's default value.
    var cachePolicy: URLRequest.CachePolicy { get }
    /// timeout interval for request. Default is 60 seconds, which is Apple's default.
    var timeoutInterval: TimeInterval { get }
    /// URLRequest object which is created usign the url from DMEndpoint
    var urlRequest: URLRequest { get }
}

extension DMRequest {
    var cachePolicy: URLRequest.CachePolicy {
        .useProtocolCachePolicy
    }

    var timeoutInterval: TimeInterval {
        60.0
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: url,
                   cachePolicy: cachePolicy,
                   timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue
        return request
    }
}
