//
//  GetCharacterListUseCase.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation

protocol GetCharacterListUseCaseType {
    func execute(pageNumber: String, completion: @escaping (CharacterListModel?, Error?) -> Void)
}

final class GetCharacterListUseCase: GetCharacterListUseCaseType {
    
    let repository: CharacterListRepository
    
    init(repository: CharacterListRepository = CharacterListRepositoryImplemented()) {
        self.repository = repository
    }
    
    func execute(pageNumber: String, completion: @escaping (CharacterListModel?, Error?) -> Void) {
        self.repository.getCharacterList(pageNumber: pageNumber) { (characterList, error) in
            DispatchQueue.main.async {
                completion(characterList, error)
            }
        }
    }
}
