//
//  NetworkManager.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 12.03.23.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

struct NetworkManager: NetworkManagerProtocol {

    internal var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func fetchData<T: Decodable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.invalidData))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
