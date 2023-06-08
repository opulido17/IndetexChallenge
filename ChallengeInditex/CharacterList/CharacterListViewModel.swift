//
//  CharacterListViewModel.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import Foundation
import Combine

protocol CharacterListViewModelProtocol: AnyObject, ObservableObject {
    func getCharacterList()
    func shouldLoadNextPage() -> Bool
}

struct LoadMorePageState {
    let isLoading: Bool
    let hasMorePages: Bool
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    @Published var characterList: [Results] = [Results]()
    @Published var serviceStatus: ProcessStatus = .idle
    @Published var shouldShowError: Bool = false
    @Published var loadMorePageState: LoadMorePageState = LoadMorePageState(isLoading: false, hasMorePages: true)
    private let characterListUseCase: GetCharacterListUseCaseType
    private(set) var pageNumber: Int = 0
    
    init(characterListUseCase: GetCharacterListUseCaseType = GetCharacterListUseCase()) {
        self.characterListUseCase = characterListUseCase
    }
    
    func getCharacterList() {
        self.serviceStatus = .loading
        self.loadNetxPage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.characterListUseCase.execute(pageNumber: String(self.pageNumber)) { [weak self] (characterList, error) in
                guard let characterList = characterList, error == nil else {
                    self?.serviceStatus = .failure
                    self?.pageNumber -= 1
                    self?.shouldShowError = true
                    self?.loadMorePageState = LoadMorePageState(isLoading: false, hasMorePages: false)
                    return
                }
                characterList.results?.forEach{ character in
                    self?.characterList.append(character)
                }
                self?.serviceStatus = .success
                self?.loadMorePageState = LoadMorePageState(isLoading: false, hasMorePages: (characterList.info?.next != nil))
            }
        }
    }
    
    func shouldLoadNextPage() -> Bool {
        if !self.loadMorePageState.isLoading && self.loadMorePageState.hasMorePages {
            return true
        }
        return false
    }
    
    private func loadNetxPage() {
        if self.loadMorePageState.isLoading || !self.loadMorePageState.hasMorePages { return }
        self.loadMorePageState = LoadMorePageState(isLoading: true, hasMorePages: true)
        self.pageNumber += 1
    }
}
