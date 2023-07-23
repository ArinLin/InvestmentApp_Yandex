//
//  NetworkFetchData.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 23.07.2023.
//

import Foundation


class NetworkDataFetch {
    static let shared = NetworkDataFetch(); private init() {}
    
    func fetchStock(urlString: String, responce: @escaping (StockData?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlStripg: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let stocks = try JSONDecoder().decode(StockData.self, from: data)
                    responce(stocks, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
