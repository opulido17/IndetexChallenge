//
//  CharacterDetailView.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 6/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetailView: View {
    
    var characterModel: Results
    
    var body: some View {
        VStack {
            Text(self.characterModel.name)
                .font(Font.custom(FontName.bold.rawValue, size: 25))
                .foregroundColor(CustomColor.darkText)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            AnimatedImage(url: URL(string: self.characterModel.image ?? Constants.DefaultImage.defaultImageError))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            VStack {
                Text(self.characterModel.status ?? "Unknown")
                    .font(Font.custom(FontName.bold.rawValue, size: 15))
                    .foregroundColor(CustomColor.lightWhite)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 30)
            .background(CustomColor.getColorCharacterStatus(characterModel.status))
            .cornerRadius(3)
            .padding([.top, .bottom], 5)
            VStack(alignment: .leading) {
                HStack {
                    Text("Gender: ")
                        .font(Font.custom(FontName.bold.rawValue, size: 12))
                        .foregroundColor(CustomColor.darkText)
                    Text(self.characterModel.gender)
                        .font(Font.custom(FontName.medium.rawValue, size: 12))
                        .foregroundColor(CustomColor.mediumGray)
                }
                HStack {
                    Text("Location:")
                        .font(Font.custom(FontName.bold.rawValue, size: 12))
                        .foregroundColor(CustomColor.darkText)
                    Text(self.characterModel.location?.name)
                        .font(Font.custom(FontName.medium.rawValue, size: 12))
                        .foregroundColor(CustomColor.mediumGray)
                }
                HStack {
                    Text("Origin:")
                        .font(Font.custom(FontName.bold.rawValue, size: 12))
                        .foregroundColor(CustomColor.darkText)
                    Text(self.characterModel.origin?.name)
                        .font(Font.custom(FontName.medium.rawValue, size: 12))
                        .foregroundColor(CustomColor.mediumGray)
                }
                HStack {
                    Text("Species:")
                        .font(Font.custom(FontName.bold.rawValue, size: 12))
                        .foregroundColor(CustomColor.darkText)
                    Text(self.characterModel.species)
                        .font(Font.custom(FontName.medium.rawValue, size: 12))
                        .foregroundColor(CustomColor.mediumGray)
                }
            }
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 50)
        .background(CustomColor.lightWhite)
        .shadow(color: CustomColor.blueSky, radius: 3.0)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(characterModel: Results.getModelResultBasic())
    }
}
