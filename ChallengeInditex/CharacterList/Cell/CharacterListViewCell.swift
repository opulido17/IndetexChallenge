//
//  CharacterListViewCell.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 5/06/23.
//

import SwiftUI
import SDWebImageSwiftUI
import SkeletonUI

struct CharacterListViewCell: View {
    
    var characterModel: Results
    var servicesStatus: ProcessStatus
    var cellFrame: CGSize = CGSize(width: 150, height: 270)
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                AnimatedImage(url: URL(string: self.characterModel.image ?? Constants.DefaultImage.defaultImageError))
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .skeleton(with: self.isLoading(), size: CGSize(width: 100, height: 100), transition: .slide)
                VStack(alignment: .trailing) {
                    Text(self.characterModel.status ?? "Unknown")
                        .font(Font.custom(FontName.bold.rawValue, size: 12))
                        .foregroundColor(CustomColor.lightWhite)
                        .padding(.horizontal, 3)
                }
                .frame(height: 15)
                .background(CustomColor.getColorCharacterStatus(characterModel.status))
                .cornerRadius(3)
                .padding(4)
                .skeleton(with: self.isLoading(), size: CGSize(width: 50, height: 15))
            }
            VStack(alignment: .leading) {
                Text(self.characterModel.name)
                    .font(Font.custom(FontName.bold.rawValue, size: 14))
                    .foregroundColor(CustomColor.darkText)
                    .lineLimit(2)
                    .skeleton(with: self.isLoading(), size: CGSize(width: 150, height: 13))
                    .padding(.bottom, 3)
                Text("Last Location")
                    .font(Font.custom(FontName.medium.rawValue, size: 10))
                    .foregroundColor(CustomColor.mediumGray)
                    .skeleton(with: self.isLoading(), size: CGSize(width: 100, height: 10))
                Text(self.characterModel.location?.name)
                    .font(Font.custom(FontName.medium.rawValue, size: 11))
                    .foregroundColor(CustomColor.darkText)
                    .lineLimit(2)
                    .skeleton(with: self.isLoading(), size: CGSize(width: 100, height: 10))
                    .padding(.bottom, 5)
            }
            .padding(.horizontal, 9)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: self.cellFrame.width, height: self.cellFrame.height)
        .background(CustomColor.lightWhite)
        .cornerRadius(7)
        .shadow(color: CustomColor.darkBlue, radius: 3.0)
    }
    
    private func isLoading() -> Bool {
        return self.servicesStatus == .loading
    }
}

struct CharacterListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListViewCell(characterModel: Results.getModelResultBasic(), servicesStatus: .loading)
    }
}
