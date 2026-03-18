//
//  entryOption.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct EntryOption: View {
    
    var icon: String
    var optionTitle: String
    
    var body: some View {
        
        VStack(spacing: 16){
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 32)
            
            Text(optionTitle)
                .font(.system(size: 12))
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(RoundedRectangle(cornerRadius: 20).fill(.green4).stroke(.green15.opacity(0.4), lineWidth: 2))
        .foregroundStyle(Color.white)
    }
}

#Preview {
    EntryOption(icon: "character.circle.fill", optionTitle: "note")
}
