//
//  IndeterminateProgressView.swift
//  ChallengeInditex
//
//  Created by Orlando Jose Pulido Marenco on 7/06/23.
//

import SwiftUI

struct IndeterminateProgressView: View {
    
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ProgressView(value: self.downloadAmount, total: 100)
            .frame(height: 2)
            .padding(0)
            .onReceive(self.timer) { _ in
                if self.downloadAmount < 100 {
                    self.downloadAmount += 2
                } else {
                    self.downloadAmount = 0
                }
            }
            .onAppear {
                self.downloadAmount = 0
            }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        IndeterminateProgressView()
    }
}
