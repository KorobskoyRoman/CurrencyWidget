//
//  ErrorView.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 20.07.2023.
//

import SwiftUI
import WidgetKit

struct ErrorView: View {

    var error: String

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image(systemName: "wifi.exclamationmark")
            Text(error)
        }
        .padding()
        .foregroundColor(.red)
        .font(.system(size: 14))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Can't display widget, try again in 1 min")
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
