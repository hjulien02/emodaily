//
//  EcranDefis.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import SwiftUI

struct EcranDefis: View {
    @State var isSelected = false
    
    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            VStack (spacing: 20) {
                Title(title: "Défis")
                ScrollView(.horizontal) {
                    Button {
                        isSelected.toggle()
                    } label: {
                        Text("Individuel")
                    }
                    .background(isSelected ? Color.green1 : Color.bg)
                }.padding()
                
                Defi(title: "Streak 5 Jours", description: "Enregistrez 5 entrées consécutives!", emoji: "🔥", startDate: nil, endDate: nil, progress: 0, total: 5)
                
                Defi(title: "15 entrées (Mars)", description: "Enregistrez 15 entrées en mars!", emoji: "📝", startDate: nil, endDate: nil, progress: 10, total: 15)
                
                Defi(title: "Artiste dans l'âme", description: "Dessinez sur 10 entrées consécutives!", emoji: "🎨", startDate: nil, endDate: nil, progress: 0, total: 10)
            }
            .padding()
        }
    }
}

#Preview {
    EcranDefis()
}
