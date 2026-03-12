//
//  EcranStats.swift
//  projetEmoDaily
//
//  Created by Thomas Jegou on 04/03/2026.
//  Created by ThomasJ on 10/03/2026.
//

import SwiftUI

struct EcranStats: View {

    @State private var moisActuel = "Mars 2026"
    @State private var semaineActuelle = "Semaine 10"
    @State private var jourSelectionne = 10

    private let jours: [(lettre: String, numero: Int)] = [
        ("L", 10), ("M", 11), ("M", 12), ("J", 13),
        ("V", 14), ("S", 15), ("D", 16)
    ]

    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color("background").ignoresSafeArea()

                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Title(title: "Statistiques")
                            Spacer()
                            Button { } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        

                        VStack(spacing: 4) {
                            
                            HStack(spacing: 24) {
                                Button { } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.black)
                                }
                                Text(moisActuel)
                                    .font(.title3.weight(.semibold))
                                    .foregroundStyle(.black)
                                Button { } label: {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.black)
                                }
                            }
                            Text(semaineActuelle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)

                        HStack(spacing: 8) {
                            ForEach(jours, id: \.numero) { jour in
                                Button {
                                    jourSelectionne = jour.numero
                                } label: {
                                    VStack(spacing: 2) {
                                        Text(jour.lettre)
                                            .font(.caption.weight(.semibold))
                                        Text("\(jour.numero)")
                                            .font(.caption.weight(.bold))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(
                                        jourSelectionne == jour.numero
                                            ? Color("green1")
                                            : Color("green1").opacity(0.35)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .foregroundStyle(.black)
                                }
                            }
                        }

                        Text("Mood")
                            .font(.title3.weight(.semibold))

                        HStack(spacing: 24) {
                            ZStack {
                                Circle()
                                    .trim(from: 0, to: 0.7)
                                    .stroke(Color("green4"), lineWidth: 20)
                                    .rotationEffect(.degrees(-90))

                                Circle()
                                    .trim(from: 0.7, to: 0.9)
                                    .stroke(Color("green3"), lineWidth: 20)
                                    .rotationEffect(.degrees(-90))

                                Circle()
                                    .trim(from: 0.9, to: 1.0)
                                    .stroke(Color("green2"), lineWidth: 20)
                                    .rotationEffect(.degrees(-90))
                            }
                            .frame(width: 120, height: 120)

                            VStack(alignment: .leading, spacing: 12) {
                                MoodStat(couleur: Color("green2"), pourcentage: "10%", emoji: "😊")
                                MoodStat(couleur: Color("green3"), pourcentage: "20%", emoji: "😐")
                                MoodStat(couleur: Color("green4"), pourcentage: "70%", emoji: "😔")
                            }
                            

                            Spacer()
                        }
                        .padding(.top, 10)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                            Button { } label: { CategorieCard(icone: "bed.double.fill",   label: "Sommeil") }
                            Button { } label: { CategorieCard(icone: "fork.knife",        label: "Appetit") }
                            Button { } label: { CategorieCard(icone: "bolt.fill",         label: "Énergie") }
                            Button { } label: { CategorieCard(icone: "waveform.path.ecg", label: "Anxiété") }
                        }
                        .padding(.top, 30)

                        HStack(spacing: 10) {
                            StatBottom(label: "Entrées",    valeur: "6")
                            StatBottom(label: "Challenges", valeur: "1")
                            StatBottom(label: "Tampons",    valeur: "19")
                        }
                        .padding(.top, 14)

                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                }
            }
            
        }
    }
}


private struct MoodStat: View {
    let couleur: Color
    let pourcentage: String
    let emoji: String

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(couleur)
                .frame(width: 22, height: 22)
            Text(pourcentage)
                .font(.subheadline.weight(.semibold))
            Text(emoji)
        }
    }
}


#Preview {
    EcranStats()
}
