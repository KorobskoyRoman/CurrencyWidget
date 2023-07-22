//
//  UserDefaultsService.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 22.07.2023.
//

import Foundation

struct UserDefaultsService {

    private let defaults = UserDefaults.standard
}

extension UserDefaultsService {

    func saveVolatilityData(date: String, value: Double) {
//        let day = date.getDay()

        guard let _ = defaults.object(forKey: date) else {
            defaults.set(value, forKey: date)
            return
        }

//        if let currentSavedDay = defaults.string(forKey: date) {
//            let savedDay = currentSavedDay
//        } else {
//            defaults.set(value, forKey: date)
//        }
    }

    func getViolityData(date: String, currentValue: Double) -> Double {
        let firstValue = defaults.double(forKey: date)
        let diff = currentValue - firstValue
        let volatility = (diff / firstValue) * 100
        return volatility
    }
}

extension String {

    func getDay() -> Int? {
        let df = DateFormatter()
        let date = df.date(from: self)

        if let date {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            return day
        } else {
            return nil
        }
    }
}
