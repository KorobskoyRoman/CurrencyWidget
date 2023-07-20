//
//  Provider.swift
//  WidgetsExtension
//
//  Created by Roman Korobskoy on 20.07.2023.
//

import WidgetKit

struct Provider: TimelineProvider {

    private let service = FetchCurrencyService()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), currency: nil, error: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            let currentDate = Date()
            var entry: SimpleEntry

            do {
                let currency = try await service.fetchCurrency()
                entry = SimpleEntry(date: currentDate, currency: currency, error: nil)
            } catch {
                entry = SimpleEntry(date: currentDate, currency: nil, error: error.localizedDescription)
            }

            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let currentDate = Date()
            var entry: SimpleEntry

            do {
                let currency = try await service.fetchCurrency()
                print(currency)
                entry = SimpleEntry(date: currentDate, currency: currency, error: nil)
            } catch {
                entry = SimpleEntry(date: currentDate, currency: nil, error: error.localizedDescription)
            }

//            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
            let nextUpdate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }

    static func scheduleRefresh() {
//        let currentDate = Date()
//        let nextUpdate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
//        let timeline = Timeline(entries: [SimpleEntry(date: currentDate, currency: nil)], policy: .after(nextUpdate))
//        WidgetCenter.shared.reloadTimelines(ofKind: "Widgets")
        let userDefaults = UserDefaults(suiteName: "com.underscoreow.CurrencyWidget")
        let currentDate = Date()

        if let lastUpdate = userDefaults?.object(forKey: "lastUpdate") as? Date {
            let timeElapsed = currentDate.timeIntervalSince(lastUpdate)
            if timeElapsed >= 5 {
                WidgetCenter.shared.reloadTimelines(ofKind: "StrictlyWidget")
                userDefaults?.set(currentDate, forKey: "lastUpdate")
            }
        } else {
            userDefaults?.set(currentDate, forKey: "lastUpdate")
        }
    }
}
