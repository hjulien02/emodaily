//
//  HealthSlider.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct HealthSlider: View {
    
    var message: String
    var 
    
    var body: some View {
        VStack{
            Text("")
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(.green.opacity(0.2))
            .stroke(Color.accentColor.opacity(0.1), lineWidth: 1))
        
    }
}

#Preview {
    HealthSlider()
}
