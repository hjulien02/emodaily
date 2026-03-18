//
//  projetEmoDailyApp.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 04/03/2026.
//

import SwiftUI

@main
struct projetEmoDailyApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}
