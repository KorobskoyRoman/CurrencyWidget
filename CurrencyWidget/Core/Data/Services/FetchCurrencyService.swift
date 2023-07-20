//
//  FetchCurrencyService.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import Foundation

struct FetchCurrencyService {

    private let requestManager: RequestManagerType

    init(requestManager: RequestManagerType = RequestManager()) {
        self.requestManager = requestManager
    }
}

extension FetchCurrencyService {

    func fetchCurrency() async throws -> Currency {
        let requestData = RequestModel.getConvert

        do {
            let currency: Currency = try await requestManager.perform(requestData)
            return currency
        } catch {
            print(error)
            throw NetworkError.invalidServerResponse
        }
    }
}
