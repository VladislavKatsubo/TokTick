//
//  Coins.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 14.03.23.
//

import Foundation

enum Coins: String, Equatable, CaseIterable {
    case btc
    case eth
    case trx
    case sol
    case dot
    case doge
    case usdt
    case xlm
    case ada

    private var urlString: String {
        return "https://data.messari.io/api/v1/assets/\(self.endpoint)/metrics"
    }

    private var endpoint: String {
        switch self {
        case .btc: return "btc"
        case .eth: return "eth"
        case .trx: return "tron"
        case .sol: return "solana"
        case .dot: return "polkadot"
        case .doge: return "dogecoin"
        case .usdt: return "tether"
        case .xlm: return "stellar"
        case .ada: return "cardano"
        }
    }

    var url: URL? {
        return URL(string: urlString)
    }

    var unicodeSymbol: String {
        switch self {
        case .btc: return "₿"
        case .eth: return "Ξ"
        case .trx: return "⛀"
        case .sol: return "◎"
        case .dot: return "●"
        case .doge: return "Ð"
        case .usdt: return "₮"
        case .xlm: return "*"
        case .ada: return "₳"
        }
    }
}
