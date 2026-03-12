//
//  PickerButton.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 10/03/2026.
//

import SwiftUI

struct PickerButton: View {
    
    @State var text: String
    @Binding var selectedPicker: String
    
        var body: some View {
            
            Button {
                selectedPicker = text
            } label: {
                Text(text)
                    .font(.system(size: 16))
                    .foregroundStyle(.text)
                    .bold()
            }
            .padding()
            .frame(width: 120)
            .background(selectedPicker == text ? .green1 : .bg)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    
        }
}

#Preview {
    PickerButton(text: "Semaine", selectedPicker: .constant("Semaine"))
}
