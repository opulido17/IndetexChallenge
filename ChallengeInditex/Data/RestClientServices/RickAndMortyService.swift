//
//  RickAndMortyService.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation

enum RickAndMortyService {
    case character(pageNumber: String)
}

extension RickAndMortyService: ServiceContract {
    var baseURL: String {
        return Constants.BaseURL.baseUrl
    }
    
    var path: String? {
        switch self {
        case .character(pageNumber: let pageNumber):
            return Constants.Paths.characterPath + pageNumber
        }
    }
    
    var urlRequest: URLRequest? {
        switch self {
        case .character:
            guard let path = self.path,
                  let url = URL(string: self.baseURL + path) else {
                return nil
            }
            return URLRequest(url: url)
        }
    }
}
