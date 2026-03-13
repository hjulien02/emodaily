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
    var emotionText: String
    var emoji: String
    
    var body: some View {
        Button{
                entry.emotion = emotion
        }label: {
            VStack(spacing: 2){
                ZStack{
                    Circle()
                        .fill(entry.emotion == emotion ? .green2 : Color.background.opacity(0.2))
                        .stroke(entry.emotion == emotion ? Color.green3.opacity(0.4) : Color.background.opacity(0.4), lineWidth: entry.emotion == emotion ? 2 : 1)
                        .frame(minWidth: 32, minHeight: 32)

                    Text(emoji)
                        .frame(minWidth: 24, minHeight: 24)
                }
                
                Text(emotionText)
                    .font(.system(size: 12))
                    .foregroundStyle(entry.emotion == emotion ? .green4 : .text)
            }
            .padding(8)
        }

    }
}

#Preview {
    EmotionButton(entry: entriesData[0], emotion: entriesData[0].emotion, emotionText: entriesData[0].emotion.rawValue, emoji: "")
}
