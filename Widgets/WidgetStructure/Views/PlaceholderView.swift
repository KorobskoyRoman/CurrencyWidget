//
//  PlaceholderView.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 22.07.2023.
//

import SwiftUI
import WidgetKit

struct PlaceholderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 39.5) {
            HStack(spacing: 12) {
                Image("img_flag_Zero")
                    .frame(width: 32, height: 24)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 2) {
                    Text("sample text")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
                .frame(width: 32, height: 12)
                .cornerRadius(5)
                .redacted(reason: .placeholder)

            }

            VStack(alignment: .leading) {
                Text("sample text")
                    .font(.system(size: 36))
                    .frame(width: 84, height: 24)
                    .redacted(reason: .placeholder)
                    .cornerRadius(15)

                Text("sample text")
                    .font(.system(size: 12))
                    .frame(width: 32, height: 12)
                    .redacted(reason: .placeholder)
                    .cornerRadius(15)
            }
        }.padding(.trailing)
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
