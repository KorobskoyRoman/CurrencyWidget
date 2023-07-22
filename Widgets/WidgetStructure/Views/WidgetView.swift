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
    var volatility: Double?

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                Image("img_flag_" + currencyName)
                    .frame(width: 32, height: 24)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 2) {
                    Text(currencyName)
                        .font(.system(size: 12))
                        .foregroundColor(.currencyName)
                    Text("24 hours")
                        .font(.system(size: 10))
                        .foregroundColor(.data)
                }
            }

            makeSplitLabel(count: currency.rates[currencyName] ?? 1)
                .foregroundColor(.currencyValue)
            makeVolatility()
        }.padding(.trailing)
    }

    private func makeSplitLabel(count: Double) -> some View {
        let count = String(format: "%.2f", count)
        let splitedValue = count.split(separator: ".")

        return HStack(alignment: .firstTextBaseline, spacing: .zero) {
            ForEach(0..<splitedValue.count, id: \.self) { index in
                switch index {
                case 0:
                    Text(splitedValue[index])
                        .font(.system(size: 36))
                case 1:
                    HStack(spacing: 3) {
                        Text("." + splitedValue[index])
                            .font(.system(size: 26))
                        Text(currency.currencySymbol(for: currencyName))
                    }
                default: Text("")
                }
            }
        }
    }

    private func makeVolatility() -> some View {
        guard let volatility else { return Text("—") }

        let color: Color = volatility > 0 ? .volatilityNegative : .volatilityPositive
        let symbol = volatility > 0 ? "+" : ""
        let formatted = volatility == 0 ?
        String(format: "%.0f", volatility) :
        String(format: "%.2f", volatility)

        return Text(symbol + formatted + "%")
            .foregroundColor(volatility == 0 ? .volatilityZero : color)
            .font(.system(size: 12))
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(currency: .mockCurrency, currencyName: "USD", volatility: 2.34)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
