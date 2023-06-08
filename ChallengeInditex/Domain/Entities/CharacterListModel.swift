//
//  CharacterListModel.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation

struct CharacterListModel: Decodable {
    let info: PaginationModel?
    let results: [Results]?
}

struct PaginationModel: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct Results: Decodable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

struct Origin: Decodable {
    let name: String?
    let url: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}


// MARK - Extensions
extension Results {
    static func getModelResultBasic() -> Results {
        return Results(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: nil, location: nil, image: "", episode: [], url: "", created: "")
    }
}
