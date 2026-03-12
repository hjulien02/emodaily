
//  EcranProfil.swift
//  projetEmoDaily
//
//  Created by ThomasJ on 10/03/2026.
//


import SwiftUI

struct EcranProfil: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Spacer()
                        HStack {
                            Title(title: "Profil")                    }
                        

                        HStack(spacing: 16) {
                            ZStack(alignment: .topTrailing) {
                                Image("default")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.black)
                                    .offset(x: -1, y: -1)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Profil")
                                    .font(.title2.weight(.semibold))
                                Text("Test")
                                    .font(.title2.weight(.semibold))
                            }
                            .foregroundStyle(.black)
                            Spacer()
                        }
                        .padding(16)
                        .background(Color("green1"))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                        Text("Compte")
                            .font(.title3.weight(.semibold))

                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(Color("green1")).frame(width: 40, height: 40)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 17, weight: .medium))
                            }
                            Text("Informations personnelles")
                                .bold()
                        }

                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(Color("green1")).frame(width: 40, height: 40)
                                Image(systemName: "bell.fill")
                                    .font(.system(size: 17, weight: .medium))
                            }
                            Text("Notifications")
                                .bold()
                        }

                        Text("Personnalisation")
                            .font(.title3.weight(.semibold))

                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(Color("green1")).frame(width: 40, height: 40)
                                Image(systemName: "tv.fill")
                                    .font(.system(size: 17, weight: .medium))
                            }
                            Text("Écran et Apparence")
                                .bold()
                        }

                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(Color("green1")).frame(width: 40, height: 40)
                                Image(systemName: "figure")
                                    .font(.system(size: 17, weight: .medium))
                            }
                            Text("Accessibilité")
                                .bold()
                        }

                        Text("Support")
                            .font(.title3.weight(.semibold))

                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(Color("green1")).frame(width: 40, height: 40)
                                Image(systemName: "key.fill")
                                    .font(.system(size: 17, weight: .medium))
                            }
                            Text("Permissions de l'application")
                                .bold()
                        }

                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(Color("green1")).frame(width: 40, height: 40)
                                Image(systemName: "message.fill")
                                    .font(.system(size: 17, weight: .medium))
                            }
                            Text("Vos retours")
                                .bold()
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                }
            }
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    EcranProfil()
}
