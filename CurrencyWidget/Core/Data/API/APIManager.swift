//
//  APIManager.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import Foundation

protocol APIManagerType {
    func perform(_ request: RequestProtocol) async throws -> Data
}

final class APIManager: APIManagerType {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func perform(_ request: RequestProtocol) async throws -> Data {
        let urlRequest = try request.createURLRequest()
        let (data, response) = try await urlSession.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }

        return data
    }
}
