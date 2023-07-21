//
//  SimpleEntry.swift
//  WidgetsExtension
//
//  Created by Roman Korobskoy on 20.07.2023.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let currency: Currency?
    let error: String?
    let selectedCurrency: String?
}
