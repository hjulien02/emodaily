//
//  Title.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import SwiftUI

struct Title: View {
    let title: String
    
    var body: some View {
        Text(title)
            .padding()
            .font(.custom("Noteworthy", size: 32))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    Title(title: "Quêtes")
}
