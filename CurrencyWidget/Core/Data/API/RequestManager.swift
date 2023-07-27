//
//  RequestManager.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import Foundation

protocol RequestManagerType {
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

final class RequestManager: RequestManagerType {
    let apiManger: APIManagerType
    let parser: DataParserType

    init(
        apiManger: APIManagerType = APIManager(),
        parser: DataParserType = DataParser()
    ) {
        self.apiManger = apiManger
        self.parser = parser
    }

    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManger.perform(request)
        let decoded: T = try parser.parse(data: data)

        return decoded
    }
}
