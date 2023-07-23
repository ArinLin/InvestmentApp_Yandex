//
//  StockDataModel.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 23.07.2023.
//



// https://finnhub.io/api/v1/stock/symbol?exchange=US&token=

import Foundation

struct StockData: Decodable {
    let description: String
    let displaySymbol: String
}

// https://finnhub.io/api/v1/stock/profile2?symbol=KSRPF&token=

struct StockDataModel: Decodable {
    let logo: String
    let name: String
    let ticker: String
}

// https://finnhub.io/api/v1/quote?symbol=AAPL&token=

struct StockPrice: Decodable {
    let c: Double // Current price
    let dp: Double // Percent change
}
