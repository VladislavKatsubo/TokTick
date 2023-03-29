//
//  APIEndpoint.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 28.03.23.
//

import Foundation

enum APIEndpoint {
    case metrics(token: Token)

    private static let baseURLString = "https://data.messari.io/api/v1/assets/"

    var url: URL? {
        switch self {
        case .metrics(let token):
            return URL(string: "\(APIEndpoint.baseURLString)\(token.endpoint)/metrics")
        }
    }
}
