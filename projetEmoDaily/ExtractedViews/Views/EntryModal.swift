//
//  EntryModal.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 16/03/2026.
//

import SwiftUI

struct EntryModal: View {

    let entry: Entry
    let today = Date()

    //Ferme la vue actuelle (pas de synchronisation comme le Binding)
    @Environment(\.dismiss) var dismiss

    var body: some View {

        ZStack {

            Color.bg.ignoresSafeArea()

            VStack {

                //Date selectionnée
                Text(
                    entry.date.formatted(
                        .dateTime.day().month(.wide).year().locale(
                            Locale(identifier: "fr_FR")
                        )
                    )
                )
                .font(.system(size: 24))
                .bold()
                .padding(.top, 20)

                ScrollView {

                    //Emotion
                    Text(entry.emotion.getEmoji())
                        .font(.system(size: 32))
                        .padding(8)
                        .background(.green15)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    Text(entry.emotion.rawValue)

                    //Etat du jour (anxiete, energie, appetit, sommeil)
                    VStack {
                        HStack {
                            Text("Ton mood")
                                .font(.system(size: 24))
                                .bold()
                            Spacer()
                        }

                        HStack {
                            StateDay(
                                emoji: entry.anxiety.getSymbol(),
                                stateTitle: "Anxiété",
                                entry: entry.anxiety.rawValue
                            )

                            StateDay(
                                emoji: entry.energy.getSymbol(),
                                stateTitle: "Energie",
                                entry: entry.energy.rawValue
                            )
                        }

                        HStack {
                            StateDay(
                                emoji: entry.appetite.getSymbol(),
                                stateTitle: "Appetit",
                                entry: entry.appetite.rawValue
                            )

                            StateDay(
                                emoji: entry.sleep.getSymbol(),
                                stateTitle: "Sommeil",
                                entry: entry.sleep.rawValue
                            )
                        }
                    }///end VStack
                        .padding(.vertical)

                    //Notes
                    if entry.notes != nil {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Tes pensées")
                                    .font(.system(size: 24))
                                    .bold()
                                Spacer()
                            }

                            Text(entry.notes ?? "")
                                .padding(.top, 2)
                        }
                        .padding(.bottom)
                    }

                    //Photos
                    if let url = entry.image?.first?.url {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Tes moments")
                                    .font(.system(size: 24))
                                    .bold()
                                Spacer()
                            }

                            //Affiche l'image
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(.bottom)
                    }

                }
                ///end ScrollView

                //Bouton - Modifier l'entrée que pour le jour même
                if Calendar.current.isDateInToday(entry.date) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Modifier")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green4)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }

                Spacer()
            }///end VStack
                .padding()
        }///end ZStack

    }
}

#Preview {
    EntryModal(
        entry: Entry(
            date: Date(),
            emotion: .anger,
            notes: "une note",
            image: nil,
            anxiety: .low,
            energy: .veryhigh,
            appetite: .low,
            sleep: .allnighter
        )
    )
}
