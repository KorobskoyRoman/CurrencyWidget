//
//  Widgets.swift
//  Widgets
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import WidgetKit
import SwiftUI

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
                WidgetCenter.shared.reloadTimelines(ofKind: "Widgets")
                userDefaults?.set(currentDate, forKey: "lastUpdate")
            }
        } else {
            userDefaults?.set(currentDate, forKey: "lastUpdate")
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let currency: Currency?
    let error: String?
}

struct WidgetsEntryView: View {
    var entry: Provider.Entry

    @State private var isLoading = true

    var body: some View {
        VStack {
            if let error = entry.error {
                ErrorView(error: error)
            } else {
                if let currency = entry.currency {
                    WidgetView(currency: currency)
                } else {
                    WidgetView(currency: .mockCurrency)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
            }
        }
    }
}

struct StrictlyWidget: Widget {
    let kind: String = "Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetsEntryView(entry: entry).onAppear { Provider.scheduleRefresh() }
        }
        .configurationDisplayName("Strictly widget")
        .description("Watch the exchange rate and its changes during the day")
        .supportedFamilies([.systemSmall])
    }
}

//struct Widgets_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetsEntryView(entry: SimpleEntry(date: Date(), count: 75.14))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
