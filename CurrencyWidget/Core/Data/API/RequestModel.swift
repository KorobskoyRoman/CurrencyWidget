//
//  RequestModel.swift
//  CurrencyWidget
//
//  Created by Roman Korobskoy on 19.07.2023.
//

import Foundation

enum RequestModel: RequestProtocol {

    case getConvert

    var path: String {
        "/v1/latest"
    }

    var urlParams: [String: String?] {
        switch self {
        case .getConvert:
            var params = ["access_key": APIConstants.apiKey]
            params["symbols"] = "USD,EUR,RUB,AED"
            params["format"] = String(1)

            return params
        }
    }

    var requestType: RequestType {
        .GET
    }
}
