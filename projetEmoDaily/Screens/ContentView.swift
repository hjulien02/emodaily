//
//  ContentView.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 04/03/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiaryScreen()
                .tabItem{
                    Label("Journal", systemImage: "book.pages.fill")
                }
            QuestScreen()
                .tabItem{
                    Label("Quêtes", systemImage: "trophy.fill")
                }
            StatsScreen()
                .tabItem{
                    Label("Statistiques", systemImage: "chart.pie.fill")
                }
            ProfileScreen()
                .tabItem{
                    Label("Profil", systemImage: "person.fill")
                }
        }
        .tint(.green3)
    }
}

#Preview {
    ContentView()
}
