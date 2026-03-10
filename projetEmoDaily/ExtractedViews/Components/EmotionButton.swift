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
                Image(emoji)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 24, minHeight: 24)
            }
            .padding(8)
            .background(entry.emotion == emotion ? Color.blue :  Color.blue.opacity(0.1))
            .cornerRadius(20)
            .foregroundStyle(entry.emotion == emotion ? Color.white :  Color.blue)
            .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.accentColor.opacity(0.1), lineWidth: 1)
                )
        }

    }
}

#Preview {
    EmotionButton(entry: entriesData[0], emotion: entriesData[0].emotion, emoji: "")
}
