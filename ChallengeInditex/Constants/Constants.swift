//
//  Constants.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation

struct Constants {
    enum BaseURL {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
}

extension Constants {
    enum Paths {
        static let characterPath = "/character?page="
    }
}

extension Constants {
    enum DefaultImage {
        static let defaultImageError = "https://cdn1.iconfinder.com/data/icons/business-company-1/500/image-512.png"
        static let imageErrorServiceGeneral = "errorServiceGeneral"
    }
}

extension Constants {
    enum DefaultMessage {
        static let messageErrorGeneric = "En estos momentos la funcionalidad no está disponible. Por favor, ingresa más tarde."
    }
}
