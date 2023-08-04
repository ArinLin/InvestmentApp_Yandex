//
//  StockDataModel.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 23.07.2023.
//



// https://finnhub.io/api/v1/stock/symbol?exchange=US&token=cinvd89r01qhd71bkhk0cinvd89r01qhd71bkhkg

import Foundation

struct StockDataCollection: Decodable {
    let description: String // длинное название
    let symbol: String // короткое название или тикер
}

// https://finnhub.io/api/v1/stock/profile2?symbol=KSRPF&token=cinvd89r01qhd71bkhk0cinvd89r01qhd71bkhkg

//struct StockData: Decodable {
//    let logo: String?
//    let name: String
//    let ticker: String
//}

// искать по тикеру

// https://finnhub.io/api/v1/quote?symbol=AAPL&token=cinvd89r01qhd71bkhk0cinvd89r01qhd71bkhkg

struct StockPrice: Decodable {
    let c: Double // Current price
    let dp: Double // Percent change
    // open price
}

// codingKeys 
