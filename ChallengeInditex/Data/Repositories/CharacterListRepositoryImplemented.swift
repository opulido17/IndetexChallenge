//
//  CharacterListRepositoryImplemented.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation

final class CharacterListRepositoryImplemented: CharacterListRepository {
    func getCharacterList(pageNumber: String, completion: @escaping (CharacterListModel?, Error?) -> Void) {
        RickAndMortyService.character(pageNumber: pageNumber).execute { (result: Result<CharacterListModel?, Error>) in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
}
