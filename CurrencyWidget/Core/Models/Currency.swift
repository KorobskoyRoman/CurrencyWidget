//
//  Currency.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: Rates

    static let mockCurrency: Currency = .init(
        success: true,
        timestamp: 1689878463,
        base: "RUB",
        date: "2023-07-20",
        rates: .init(usd: 110.2, eur: 123.43, rub: 1, aed: 55.55)
    )
}

// MARK: - Rates
struct Rates: Codable {
    let usd: Double
    let eur: Double
    let rub, aed: Double

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case rub = "RUB"
        case aed = "AED"
    }
}
