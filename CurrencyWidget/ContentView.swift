//
//  ContentView.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import SwiftUI
import WidgetKit

struct ContentView: View {

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
