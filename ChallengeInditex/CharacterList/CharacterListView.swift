//
//  CharacterListView.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 4/06/23.
//

import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var viewModel = CharacterListViewModel()
    let columsNumber: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .bottom) {
                ScrollView(.vertical) {
                    LazyVGrid(columns: self.columsNumber, spacing: 15) {
                        ForEach(self.viewModel.characterList, id: \.id) { character in
                            NavigationLink(destination: CharacterDetailView(characterModel: character)) {
                                CharacterListViewCell(characterModel: character, servicesStatus: self.viewModel.serviceStatus, cellFrame: self.calculateCellFrame())
                            }
                            .disabled(self.viewModel.serviceStatus == .loading)
                        }
                        if self.viewModel.shouldLoadNextPage() {
                            Text("")
                                .onAppear {
                                    self.viewModel.getCharacterList()
                                }
                        }
                    }
                    .navigationTitle("Characters")
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
                if self.viewModel.loadMorePageState.isLoading {
                    IndeterminateProgressView()
                }
            }
        }
        .onAppear {
            self.viewModel.getCharacterList()
        }
        .popup(isPresented: $viewModel.shouldShowError) {
            ErrorAlertView(isPresented: $viewModel.shouldShowError, text: Constants.DefaultMessage.messageErrorGeneric, image: Image(Constants.DefaultImage.imageErrorServiceGeneral), confirm: {
                self.viewModel.shouldShowError = false
                self.viewModel.getCharacterList()
            })
        }
    }
    
    private func calculateCellFrame() -> CGSize {
        return CGSize(width: self.calculateCardWith(), height: 250)
    }
    
    private func calculateCardWith() -> CGFloat {
        return (UIScreen.main.bounds.width / 2) - 15
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
