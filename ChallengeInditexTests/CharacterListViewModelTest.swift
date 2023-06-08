//
//  CharacterListViewModelTest.swift
//  ChallengeInditexTests
//
//  Created by Orlando Jose Pulido Marenco on 8/06/23.
//

@testable import ChallengeInditex
import XCTest

final class CharacterListViewModelTest: XCTestCase {
    
    private var sut: CharacterListViewModel!
    private var useCaseStub: GetCharacterListUseCaseStub!
    
    override func setUp() {
        super.setUp()
        
        self.useCaseStub = GetCharacterListUseCaseStub()
        self.sut = CharacterListViewModel(characterListUseCase: self.useCaseStub)
    }
    
    override func tearDown() {
        self.useCaseStub = nil
        self.sut = nil
        
        super.tearDown()
    }
    
    func testGetCharacterList_whenIsSuccess_thenReturnCharacterList() {
        let expectation: XCTestExpectation = expectation(description: "Expectation get character successfully")
        self.sut.getCharacterList()
        
        XCTAssertEqual(self.sut.serviceStatus, .loading)
        XCTAssertEqual(self.sut.characterList.count, 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(self.sut.serviceStatus, .success)
        XCTAssertEqual(self.sut.pageNumber, 1)
        XCTAssertFalse(self.sut.shouldShowError)
        XCTAssertEqual(self.sut.characterList.count, 1)
        XCTAssertFalse(self.sut.loadMorePageState.isLoading)
        XCTAssertTrue(self.sut.loadMorePageState.hasMorePages)
    }
    
    func testGetCharacterList_whenIsFailure_thenReturnError() {
        let expectation: XCTestExpectation = expectation(description: "Expectation failure error")
        self.useCaseStub.failureCase = true
        self.sut.getCharacterList()
        
        XCTAssertEqual(self.sut.serviceStatus, .loading)
        XCTAssertEqual(self.sut.characterList.count, 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(self.sut.serviceStatus, .failure)
        XCTAssertEqual(self.sut.pageNumber, 0)
        XCTAssertTrue(self.sut.shouldShowError)
        XCTAssertEqual(self.sut.characterList.count, 0)
        XCTAssertFalse(self.sut.loadMorePageState.isLoading)
        XCTAssertFalse(self.sut.loadMorePageState.hasMorePages)
    }
    
    func testShouldLoadNextPage_whenShouldLoadNextPage_thenReturnTrue() {
        XCTAssertTrue(self.sut.shouldLoadNextPage())
    }
    
    func testShouldLoadNextPage_whenShouldNotLoadNextPage_thenReturnTrue() {
        self.sut.loadMorePageState = LoadMorePageState(isLoading: true, hasMorePages: false)
        XCTAssertFalse(self.sut.shouldLoadNextPage())
    }
    
}
