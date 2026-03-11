//
//  emotionButton.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct EmotionButton: View {
    
    var entry: Entry
    var emotion: Emotion
    var emoji: String
    
    var body: some View {
        Button{
                entry.emotion = emotion
        }label: {
            VStack{
                Text(emoji)
                    .frame(minWidth: 24, minHeight: 24)
            }
            .padding(8)
            .background(Circle()
                .fill(entry.emotion == emotion ? .green2 : .background.opacity(0.2))
                .overlay(entry.emotion == emotion ? Circle().stroke(.green3.opacity(0.4), lineWidth: 2): Circle().stroke(Color.background.opacity(0.4), lineWidth: 1) ))
        }

    }
}

#Preview {
    EmotionButton(entry: entriesData[0], emotion: entriesData[0].emotion, emoji: "")
}
