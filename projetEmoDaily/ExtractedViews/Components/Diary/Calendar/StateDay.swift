//
//  StateDay.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 16/03/2026.
//

import SwiftUI

struct StateDay: View {
    
    var emoji: String
    var stateTitle: String
    var entry: String
    
    var body: some View {
        HStack{
            Image(systemName: emoji)
                .frame(width: 24, height: 24)
            VStack(alignment: .leading){
                Text(stateTitle)
                Text(entry)
                    .foregroundStyle(.green4)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 85, alignment: .leading)
        .background(.green15)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    StateDay(emoji: "eye.half.closed.fill", stateTitle: "Sommeil", entry: "Nuit blanche")
}
