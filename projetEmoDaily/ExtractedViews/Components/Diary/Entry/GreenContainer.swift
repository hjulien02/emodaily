//
//  GreenContainer.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 13/03/2026.
//

import SwiftUI

struct GreenContainer<Content: View>: View{
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            content()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20).fill(
                .green15
            )
            .stroke(.green4.opacity(0.1), lineWidth: 2)
        )
    }
}

#Preview {
    GreenContainer(){
        VStack(alignment: .leading, spacing: 12) {
            Text("Comment s’est passée ta journée ?")
        }
    }
}
