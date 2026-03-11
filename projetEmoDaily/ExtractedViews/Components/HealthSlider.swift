//
//  HealthSlider.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct HealthSlider: View {

    var entry: Entry
    
    var message: String
    var healthLevels: [String]
    var healthIcons: [String]

    @Binding var selectedLevel: Int

    var selectedLevelMessage: String {
        let selectedLevel = healthLevels[selectedLevel]

        return selectedLevel
    }

    var columns = [GridItem(.adaptive(minimum: 20))]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(message)
                .font(.system(size: 12))

            VStack{
                HStack(alignment: .top) {
                    ForEach(0...healthIcons.count-1, id: \.self) { i in
                        let symbol = healthIcons[i]
                        
                        ZStack{
                            Circle()
                                .fill(i == selectedLevel ? .green2 : .background.opacity(0.2))
                                .overlay(i == selectedLevel ? Circle().stroke(.green3.opacity(0.4), lineWidth: 2): Circle().stroke(Color.background.opacity(0.4), lineWidth: 1) )
                                .frame(maxWidth: 36, maxHeight: 36)
                            
                            Image(systemName: symbol)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 24, maxHeight: 24)
                                .foregroundStyle(i == selectedLevel ? .green4 : .text)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)

                Slider(
                    value: Binding(
                        get: { Double(selectedLevel) },
                        set: { selectedLevel = Int($0.rounded()) }
                    ),
                    in: 0...Double(healthLevels.count - 1),
                    step: 1
                )
                .tint(.green4)
                .padding(.horizontal, 20)
                
                Text(selectedLevelMessage)
                    .font(.system(size: 12))
                    .italic()
                    .bold()
                
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(.green15)
                .stroke(.green4.opacity(0.1), lineWidth: 2)
        )

    }
}

#Preview {
    HealthSlider(
        entry: entriesData[0], message: "Titre de la section santé",
        healthLevels: AnxietyLevel.allCases.map { $0.rawValue },
        healthIcons: AnxietyLevel.allCases.map { $0.getSymbol() }, selectedLevel: .constant(3)
    )
}
