//
//  GetCharacterListUseCaseStub.swift
//  ChallengeInditexTests
//
//  Created by Orlando Jose Pulido Marenco on 8/06/23.
//

@testable import ChallengeInditex

final class GetCharacterListUseCaseStub: GetCharacterListUseCaseType {
    
    var failureCase: Bool = false
    var pageNumber: String = "1"
    
    func execute(pageNumber: String, completion: @escaping (CharacterListModel?, Error?) -> Void) {
        if self.failureCase {
            completion(nil, APINetworkError.badResponse)
        } else {
            completion(CharacterListModel.mockDefault(), nil)
        }
    }
}
