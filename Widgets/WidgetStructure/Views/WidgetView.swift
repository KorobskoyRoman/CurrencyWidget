//
//  WidgetView.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 20.07.2023.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    var currency: Currency
    var currencyName: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                Image("img_flag_" + currencyName)
                    .frame(width: 32, height: 24)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 2) {
                    Text(currencyName)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("24 hours")
                        .font(.system(size: 10))
                }
            }

            makeSplitLabel(count: currency.rates[currencyName] ?? 1)
            Text("—")
        }
    }

    private func makeSplitLabel(count: Double) -> some View {
        let count = String(format: "%.2f", count)
        let splitedValue = count.split(separator: ".")

        return HStack(alignment: .bottom, spacing: .zero) {
            ForEach(0..<splitedValue.count, id: \.self) { index in
                switch index {
                case 0:
                    Text(splitedValue[index])
                        .font(.system(size: 36))
                case 1:
                    Text("." + splitedValue[index] + currency.currencySymbol(for: currencyName))
                        .font(.system(size: 26))
                default: Text("")
                }
            }
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(currency: .mockCurrency, currencyName: "USD")
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
