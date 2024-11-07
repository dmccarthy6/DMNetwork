//
//  DMClient.swift
//  DMNetwork
//
//  Created by Dylan  on 11/4/24.
//

import Foundation

/// Defines the required methods for interacting with the REST server.
protocol NetworkClient {
    /// Perform a `GET` request.
    /// - Parameters:
    ///   - request: DMRequest object used to define the requirements for the endpoint.
    ///   - value: Codable object that will be used to decode the JSON.
    /// - Returns: The Codable object passed in when it is successfully decoded.
    func get<Object: Codable>(request: DMRequest, value: Object.Type) async throws -> Object
    /// Perform a `PUT` request.
    /// - Parameters:
    ///   - request: DMRequest object used to define the requirements for the endpoint.
    ///   - value: Codable object that will be used to decode the JSON.
    /// - Returns: The Codable object passed in when it is successfully decoded.
    /// - Note: Use the `httpBody` property of the request to pass data.
    func put(request: DMRequest) async throws -> HTTPURLResponse
    /// Perform a `POST` request.
    /// - Parameters:
    ///   - request: DMRequest object used to define the requirements for the endpoint.
    ///   - value: Codable object that will be used to decode the JSON.
    /// - Returns: The Codable object passed in when it is successfully decoded.
    /// - Note: Use the `httpBody` property of the request to pass data.
    func post(request: DMRequest) async throws -> HTTPURLResponse
    /// Perform a `DELETE` request.
    /// - Parameters:
    ///   - request: DMRequest object used to define the requirements for the endpoint.
    ///   - value: Codable object that will be used to decode the JSON.
    /// - Returns: Void.
    func delete(request: DMRequest) async throws -> Void
    /// Get data from a URL. This method can be helpful when attempting to fetch images remotely.
    /// - Parameter url: The url to fetch data from.
    /// - Returns: Data upon success.
    func data(from url: DMRequest) async throws -> Data
}

public struct DMClient: NetworkClient {
    private let session: URLSession

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    public func get<Object: Codable>(request: DMRequest, value: Object.Type) async throws -> Object {
        do {
            let (data, httpResponse) = try await makeHTTP(request: request.urlRequest)
            return try JSONDecoder().decode(value, from: data)
        } catch {
#warning("TODO: IOS-003 - Custom HTTP Error")
            throw error
        }
    }

    public func put(request: any DMRequest) async throws -> HTTPURLResponse { // TODO: Is this what I should return here, maybe status code?
        do {
            let (_ , httpResponse) = try await makeHTTP(request: request.urlRequest)
            return httpResponse
        } catch {
#warning("TODO: IOS-003 - Custom HTTP Error")
            throw error
        }
    }

    public func post(request: any DMRequest) async throws -> HTTPURLResponse {
        do {
            let (_, httpResponse) = try await makeHTTP(request: request.urlRequest)
            return httpResponse
        } catch {
#warning("TODO: IOS-003 - Custom HTTP Error")
            throw error
        }
    }

    public func delete(request: DMRequest) async throws -> Void {
        do {
            _ = try await makeHTTP(request: request.urlRequest)
            // TODO: Should I return anything here?
        } catch {
#warning("TODO: IOS-003 - Custom HTTP Error")
            throw error
        }
    }

    public func data(from url: any DMRequest) async throws -> Data {
        do {
            return try await makeHTTPRequest(url: url.url)
        } catch {
#warning("TODO: IOS-003 - Custom HTTP Error")
            throw error
        }
    }

    // MARK: - Helpers

    typealias Response = (Data, HTTPURLResponse)

    private func makeHTTP(request: URLRequest) async throws -> Response {
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw DMHTTPError.unknown
            }
            return Response(data, httpResponse)
        } catch {
#warning("TODO: IOS-003 - Custom HTTP Error")
            throw DMHTTPError.unknown
        }
    }

    private func makeHTTPRequest(url: URL) async throws -> Data {
        do {
            let (data, _) = try await session.data(from: url)
            return data
        } catch {
#warning("TODO: IOS-003 - Custom HTTP Error")
            throw error
        }
    }
}
