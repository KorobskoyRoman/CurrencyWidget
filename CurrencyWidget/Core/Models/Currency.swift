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
    let rates: [String: Double]

    func currencySymbol(for code: String) -> String {
        switch code {
        case "USD":
            return "$"
        case "EUR":
            return "€"
        case "AED":
            return "د.إ"
        case "RUB":
            return "₽"
        default:
            return code
        }
    }

    static let mockCurrency: Currency = .init(
        success: true,
        timestamp: 1689878463,
        base: "EUR",
        date: "2023-07-20",
        rates: ["USD": 1.234341414]
    )
}
