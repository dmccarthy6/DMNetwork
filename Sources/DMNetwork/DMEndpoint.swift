//
//  DMEndpoint.swift
//  DMNetwork
//
//  Created by Dylan  on 11/4/24.
//

import Foundation

/// Defines the basic elements that create an endpoint. A default
/// value of `URL` is provided. This default value utilizes `URLComponents` to
/// create the URL.
public protocol DMEndpoint {
    /// URL scheme
    var scheme: String { get }
    /// URL host
    var host: String { get }
    /// URL path
    var path: String { get }
    /// URL query items
    var queryItems: [URLQueryItem]? { get }
    /// URL
    var url: URL { get }
}

extension DMEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else {
            fatalError("Invalid URL: \(components.debugDescription)")
        }
        return url
    }
}
