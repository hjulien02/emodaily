//
//  emotionButton.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct EmotionButton: View {
    
    @Binding var selectedEmotion: Emotion
    var emotion: Emotion
    var emotionText: String
    var emoji: String
    
    var body: some View {
        Button{
            selectedEmotion = emotion
        } label: {
            VStack(spacing: 2){
                
                ZStack {
                    Circle()
                        .fill(selectedEmotion == emotion ? .green2 : .bg.opacity(0.2))
                        .stroke(selectedEmotion == emotion ? Color.green3.opacity(0.4) : .bg.opacity(0.4), lineWidth: selectedEmotion == emotion ? 2 : 1)
                        .frame(minWidth: 32, minHeight: 32)

                    Text(emoji)
                        .frame(minWidth: 24, minHeight: 24)
                }

                Text(emotionText)
                    .font(.system(size: 12))
                    .foregroundStyle(selectedEmotion == emotion ? .green4 : .text)
            }
            .padding(8)
        }

    }
}

#Preview {
    @Previewable @State var selectedEmotion: Emotion = Emotion.boredom
    
    EmotionButton(selectedEmotion: $selectedEmotion, emotion: Emotion.boredom, emotionText: Emotion.boredom.rawValue, emoji: Emotion.boredom.getEmoji())
}

