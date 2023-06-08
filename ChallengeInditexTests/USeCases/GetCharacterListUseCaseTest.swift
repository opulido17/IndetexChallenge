//
//  GetCharacterListUseCaseTest.swift
//  ChallengeInditexTests
//
//  Created by Orlando Jose Pulido Marenco on 8/06/23.
//

@testable import ChallengeInditex
import XCTest

final class GetCharacterListUseCaseTest: XCTestCase {
    
    private var sut: GetCharacterListUseCaseType!
    private var repositoryStub: RepositoryImplemendTestable!
    
    override func setUp() {
        super.setUp()
        
        self.repositoryStub = RepositoryImplemendStub()
        self.sut = GetCharacterListUseCase(repository: self.repositoryStub)
    }
    
    override func tearDown() {
        self.repositoryStub = nil
        self.sut = nil
        
        super.tearDown()
    }
    
    func testExecute_whenServiceSuccess_thenReturnData() {
        let expectation = XCTestExpectation(description: "Wait until success.")
        var expectedResponse: CharacterListModel?
        
        let dataResponse = CharacterListModel.mockDefault()
        self.repositoryStub.setResponseData(dataResponse as AnyObject)
        
        self.sut.execute(pageNumber: "") { character, error in
            expectedResponse = character
            if let _ = error {
                XCTFail("Must not fail.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(expectedResponse)
        XCTAssertEqual(expectedResponse?.results?.count, 1)
    }
    
    func testExecute_whenServiceFailure_thenReturnError() {
        let expectation = XCTestExpectation(description: "Wait until fail.")
        var expectedError: APINetworkError?
        
        self.sut.execute(pageNumber: "") { character, error in
            expectedError = error as? APINetworkError
            if let _ = character {
                XCTFail("Must not success.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(expectedError)
        XCTAssertEqual(expectedError, APINetworkError.badResponse)
    }
}
