//
//  StampComponent.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 12/03/2026.
//

import SwiftUI

struct StampComponent: View {
    let stamp: Stamp
    
    var body: some View {
        VStack(spacing: 0) {
            // titre
            Text(stamp.title)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
            
            // tampons
            HStack (spacing: 15){
                ForEach(0..<5) { i in
                    ZStack {
                        Circle()
                            .fill(Color.text.opacity(0.3))
                            .frame(maxWidth: 64)
                        // superpose un tampon si le level est complété
                        if (stamp.level > i) {
                            Image("stamp")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    // alternation des paddings (haut/bas)
                    .padding(i % 2 == 0 ? .top : .bottom)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.green15)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    StampComponent(stamp: Stamp(id: "1", title: "Nombre d'entrées", questDescription: "Test", progress: 1, total: 10, questType: "stamp", level: 1, levelGoals: [1,2,5,10,20]))
}
