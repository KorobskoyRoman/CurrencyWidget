//
//  UserDefaultsService.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 22.07.2023.
//

import Foundation

protocol UserDefaultsType {
    func saveVolatilityData(date: String, value: Double)
    func getVolatilityData(date: String, currentValue: Double) -> Double
}

struct UserDefaultsService {
    private let defaults = UserDefaults.standard
}

extension UserDefaultsService: UserDefaultsType {

    func saveVolatilityData(date: String, value: Double) {
        guard let _ = defaults.object(forKey: date) else {
            defaults.set(value, forKey: date)
            return
        }
    }

    func getVolatilityData(date: String, currentValue: Double) -> Double {
        let firstValue = defaults.double(forKey: date)
        let diff = currentValue - firstValue
        let volatility = (diff / firstValue) * 100
        return volatility
    }
}
