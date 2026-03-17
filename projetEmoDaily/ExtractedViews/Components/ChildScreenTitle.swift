//
//  ChildScreenTitle.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 17/03/2026.
//

import SwiftUI

struct ChildScreenTitle: View {
    var title: String
    
    var body: some View {
            Text(title)
            .font(.system(size: 20).bold())
                .foregroundColor(.text)
    }
}

#Preview {
    ChildScreenTitle(title: "Nouvelle entrée")
}
