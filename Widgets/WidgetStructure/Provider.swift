//
//  Provider.swift
//  WidgetsExtension
//
//  Created by Roman Korobskoy on 20.07.2023.
//

import WidgetKit

struct Provider: IntentTimelineProvider {

    typealias Intent = CurrencySelectionIntent

    private let service = FetchCurrencyService()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), currency: nil, error: nil, selectedCurrency: nil)
    }

    func getSnapshot(for configuration: Intent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        Task {
            let currencyName = getCurrencyName(for: configuration)
            let currentDate = Date()
            var entry: SimpleEntry

            do {
                let currency = try await service.fetchCurrency()
                entry = SimpleEntry(date: currentDate, currency: currency, error: nil, selectedCurrency: currencyName)
            } catch {
                entry = SimpleEntry(date: currentDate, currency: nil, error: error.localizedDescription, selectedCurrency: nil)
            }

            completion(entry)
        }
    }

    func getTimeline(for configuration: Intent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        Task {
            let currencyName = getCurrencyName(for: configuration)
            let currentDate = Date()
            var entry: SimpleEntry

            do {
                let currency = try await service.fetchCurrency()
                print(currency)
                entry = SimpleEntry(date: currentDate, currency: currency, error: nil, selectedCurrency: currencyName)
            } catch {
                entry = SimpleEntry(date: currentDate, currency: nil, error: error.localizedDescription, selectedCurrency: nil)
            }

//            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
            let nextUpdate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }

    private func getCurrencyName(for configuration: Intent) -> String {
        switch configuration.Currency {
        case .uSD:
            return "USD"
        case .eUR:
            return "EUR"
        case .aED:
            return "AED"
        case .rUB:
            return "RUB"
        default: return "USD"
        }
    }

    static func scheduleRefresh() {
//        WidgetCenter.shared.reloadTimelines(ofKind: "StrictlyWidget") // 1 раз в сек

//        let userDefaults = UserDefaults(suiteName: "com.underscoreow.CurrencyWidget")
//        let currentDate = Date()
//
//        if let lastUpdate = userDefaults?.object(forKey: "lastUpdate") as? Date {
//            let timeElapsed = currentDate.timeIntervalSince(lastUpdate)
//            if timeElapsed >= 5 {
//                WidgetCenter.shared.reloadTimelines(ofKind: "StrictlyWidget")
//                userDefaults?.set(currentDate, forKey: "lastUpdate")
//            }
//        } else {
//            userDefaults?.set(currentDate, forKey: "lastUpdate")
//        }
    }
}
