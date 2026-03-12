//
//  EcranJournal.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 04/03/2026.
//

import SwiftUI

struct EcranJournal: View {

    @State var selectedPeriod = "Mois"
    @State var period = ["Semaine", "Mois", "Année"]

    var body: some View {

        NavigationStack {
            ZStack {

                Color("background").ignoresSafeArea()
                VStack {
                    Title(title: "Journal")

                    //Affichage des periodes
                    HStack {
                        ForEach(period, id: \.self) { onePeriod in
                            PickerButton(
                                text: onePeriod,
                                selectedPicker: $selectedPeriod
                            )
                        }
                    }

                    //Ajout d'une entrée
                    NavigationLink("+", destination: EcranNouvelleEntree())
                        .foregroundStyle(.white)
                        .bold()
                        .frame(width: 64, height: 64)
                        .background(.green4)
                        .clipShape(Circle())
                        .shadow(color: .white, radius: 10)

                }
                .padding()
            }
        }
    }
}

#Preview {
    EcranJournal()
}
