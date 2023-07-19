//
//  DataParser.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import Foundation

protocol DataParserType {
    func parse<T: Decodable>(data: Data) throws -> T
}

final class DataParser: DataParserType {

    private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func parse<T>(data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
