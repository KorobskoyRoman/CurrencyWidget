//
//  Provider.swift
//  WidgetsExtension
//
//  Created by Roman Korobskoy on 20.07.2023.
//

import WidgetKit

struct Provider: IntentTimelineProvider {

    typealias Intent = CurrencySelectionIntent

    private let fetchService: FetchCurrencyType
    private let udService: UserDefaultsType

    init(
        fetchService: FetchCurrencyType = FetchCurrencyService(),
        udService: UserDefaultsType = UserDefaultsService()
    ) {
        self.fetchService = fetchService
        self.udService = udService
    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), currency: nil, error: nil, selectedCurrency: nil, volatility: nil)
    }

    func getSnapshot(
        for configuration: Intent,
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        Task {
            await getData(for: configuration, completion: completion)
        }
    }

    func getTimeline(
        for configuration: Intent,
        in context: Context,
        completion: @escaping (Timeline<SimpleEntry>) -> Void
    ) {
        Task {
            await getData(for: configuration) { entry in
                let currentDate = Date()
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            }
        }
    }

    // MARK: Private

    private func getData(
        for configuration: Intent,
        completion: @escaping (SimpleEntry) -> Void
    ) async {
        let currencyName = getCurrencyName(for: configuration)
        let currentDate = Date()
        var entry: SimpleEntry

        do {
            let currency = try await fetchService.fetchCurrency()
            print(currency)
            let udKey = currency.date + currencyName
            let currentRate = currency.rates[currencyName] ?? 1
            udService.saveVolatilityData(date: udKey, value: currentRate)
            let volatility = udService.getVolatilityData(date: udKey, currentValue: currentRate)
            entry = SimpleEntry(date: currentDate, currency: currency, error: nil, selectedCurrency: currencyName, volatility: volatility)
        } catch {
            entry = SimpleEntry(date: currentDate, currency: nil, error: error.localizedDescription, selectedCurrency: nil, volatility: nil)
        }

        completion(entry)
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

    /// API позволяет только обновление раз в час.
    /// Сейчас обновление работает и без планировщика.
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
