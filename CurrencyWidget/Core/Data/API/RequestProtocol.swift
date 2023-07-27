//
//  RequestProtocol.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }

    var headers: [String: String] { get }
    var params: [String: Any] { get }

    var urlParams: [String: String?] { get }

    var requestType: RequestType { get }
}

extension RequestProtocol {

    var host: String {
        APIConstants.host
    }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }

    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = URLTypes.http.rawValue
        components.host = host
        components.path = path

        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = components.url else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }

        return urlRequest
    }
}
