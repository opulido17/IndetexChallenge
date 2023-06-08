//
//  ServicesContract.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation

enum APINetworkError: Error {
    case invalidURL
    case badResponse
    case invalidData
    case invalidRequest
    case noFound
}

extension APINetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The connection has invalid URL.", comment: "invalidURL")
        case .badResponse:
            return NSLocalizedString("The internet connection appears to be offline.", comment: "badResponse")
        case .invalidData:
            return NSLocalizedString("The connection has invalid Data.", comment: "invalidData")
        case .invalidRequest:
            return NSLocalizedString("The connection has invalid Request.", comment: "invalidRequest")
        case .noFound:
            return NSLocalizedString("Error No Found", comment: "noFound")
        }
    }
}

public enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

public protocol ServiceContract {
    var baseURL: String { get }
    var path: String? { get }
    var urlRequest: URLRequest? { get }
    func execute<T: Decodable>(completion: @escaping (Result<T?, Error>) -> Void)
}

extension ServiceContract {
    public func execute<T: Decodable>(completion: @escaping (Result<T?, Error>) -> Void) {
        guard let urlRequest = self.urlRequest else {
            completion(.failure(APINetworkError.invalidRequest))
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if error != nil {
                completion(.failure(APINetworkError.badResponse))
                return
            }
            guard let data = data else {
                completion(.failure(APINetworkError.invalidData))
                return
            }
            let object = try? JSONDecoder().decode(T.self, from: data)
            completion(.success(object))
        }.resume()
    }
}

enum ProcessStatus {
    case idle
    case loading
    case success
    case failure
}
