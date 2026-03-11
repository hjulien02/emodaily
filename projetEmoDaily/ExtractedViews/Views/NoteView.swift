//
//  noteView.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct NoteView: View {
    var entry: Entry
    
    @State var note: String
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 24){
                VStack(spacing: 4){
                    Image(systemName: "character.circle.fill")
                        .font(.system(size: 32))
                    
                    Text("Note")
                        .font(.custom("Noteworthy", size: 16))
                        .bold()
                }
                //                    .offset(y: -24)
                
                VStack(alignment: .leading, spacing: 16){
                    Text("Que se passe-t-il ?")
                        .italic()
                        .bold()
                        .opacity(0.5)
                    
                    Text(note)
                        .font(.system(size: 12))
                    
                    Spacer()
                }
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 20).fill(
                        .green15
                    )
                    .stroke(.green4.opacity(0.1), lineWidth: 2)
                )
                
                Button{
                    entry.notes = note
                }label: {
                    ZStack{
                        Circle()
                            .fill(.green4)
                            .stroke(.green15.opacity(0.4), lineWidth: 2)
                            .frame(maxWidth: 64,maxHeight: 64)
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                            .font(.system(size: 32))
                    }
                }
                
            }
            .padding(.horizontal, 24)
            .foregroundStyle(.text)
        }
    }
}

#Preview {
    NoteView(entry: entriesData[0], note: "aujourd'hui")
}
