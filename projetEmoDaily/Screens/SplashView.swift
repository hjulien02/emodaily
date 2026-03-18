//
//  SplashView.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 18/03/2026.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("bg").ignoresSafeArea()

            Image("emodaily")
                .resizable()
                .scaledToFit()
                .frame(width: .infinity)
        }
    }
}

#Preview {
    SplashView()
}
