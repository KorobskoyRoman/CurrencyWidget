//
//  Widgets.swift
//  Widgets
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import WidgetKit
import SwiftUI

struct WidgetsEntryView: View {
    var entry: Provider.Entry

    @State private var isLoading = true

    var body: some View {
        VStack {
            if let error = entry.error {
                ErrorView(error: error)
            } else {
                if let currency = entry.currency,
                   let currencyName = entry.selectedCurrency {
                    WidgetView(currency: currency, currencyName: currencyName)
                } else {
                    WidgetView(currency: .mockCurrency, currencyName: "Zero")
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
            }
        }
    }
}

struct StrictlyWidget: Widget {
    let kind: String = "StrictlyWidget"

    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
        IntentConfiguration(kind: kind, intent: CurrencySelectionIntent.self, provider: Provider()) { entry in
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
