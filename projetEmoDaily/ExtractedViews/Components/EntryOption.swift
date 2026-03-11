//
//  entryOption.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct EntryOption: View {
    
    var icone: String
    var optionTitle: String
    
    var body: some View {
        
        VStack(spacing: 16){
            Image(systemName: icone)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 32)
            
            Text(optionTitle)
        }
        .frame(minWidth: 100, minHeight: 100)
        .background(RoundedRectangle(cornerRadius: 20).fill(.green4).stroke(.green15.opacity(0.4), lineWidth: 2))
        .foregroundStyle(Color.white)
    }
}

#Preview {
    EntryOption(icone: "character.circle.fill", optionTitle: "note")
}
