//
//  ContentView.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import SwiftUI

struct ContentView: View {

    let service: FetchCurrencyService

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await fetch()
        }
    }

    private func fetch() async {
        do {
            let currency = try await service.fetchCurrency()
            print(currency)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(service: FetchCurrencyService(requestManager: RequestManager()))
    }
}
