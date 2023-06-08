//
//  RepositoryImplemendStub.swift
//  ChallengeInditexTests
//
//  Created by Orlando Jose Pulido Marenco on 8/06/23.
//

@testable import ChallengeInditex

protocol RepositoryImplemendTestable: CharacterListRepository {
    var wasCalled: Bool { get set }

    func setResponseData(_ data: AnyObject)
    func setResponseError(_ error: APINetworkError)
}

final class RepositoryImplemendStub: RepositoryImplemendTestable {
    private var responseData: AnyObject?
    private var responseError: APINetworkError?
    var wasCalled: Bool = false
    
    func setResponseData(_ data: AnyObject) {
        self.responseData = data
    }
    
    func setResponseError(_ error: APINetworkError) {
        self.responseError = error
    }
    
    func getCharacterList(pageNumber: String, completion: @escaping (CharacterListModel?, Error?) -> Void) {
        guard let data = self.responseData else {
            completion(nil, APINetworkError.badResponse)
            return
        }
        completion(data as? CharacterListModel, nil)
    }
}
