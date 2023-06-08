//
//  CharacterListRepository.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation

protocol CharacterListRepository: AnyObject {
    func getCharacterList(pageNumber: String, completion: @escaping (CharacterListModel?, Error?) -> Void)
}
