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
}

// MARK: - Rates
struct Rates: Codable {
    let usd: Double
    let eur: Int
    let rub, aed: Double

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case rub = "RUB"
        case aed = "AED"
    }
}
