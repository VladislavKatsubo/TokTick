//
//  Token.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 14.03.23.
//

import Foundation

protocol Token {
    var symbol: String { get }
    var endpoint: String { get }
}

struct TokenInfo: Token {
    let symbol: String
    let endpoint: String
}

enum Tokens: String, Equatable, CaseIterable {
    case btc
    case eth
    case trx
    case sol
    case dot
    case doge
    case usdt
    case xlm
    case ada

    var info: TokenInfo {
        switch self {
        case .btc: return TokenInfo(symbol: self.rawValue, endpoint: "btc")
        case .eth: return TokenInfo(symbol: self.rawValue, endpoint: "eth")
        case .trx: return TokenInfo(symbol: self.rawValue, endpoint: "tron")
        case .sol: return TokenInfo(symbol: self.rawValue, endpoint: "solana")
        case .dot: return TokenInfo(symbol: self.rawValue, endpoint: "polkadot")
        case .doge: return TokenInfo(symbol: self.rawValue, endpoint: "dogecoin")
        case .usdt: return TokenInfo(symbol: self.rawValue, endpoint: "tether")
        case .xlm: return TokenInfo(symbol: self.rawValue, endpoint: "stellar")
        case .ada: return TokenInfo(symbol: self.rawValue, endpoint: "cardano")
        }
    }
}
