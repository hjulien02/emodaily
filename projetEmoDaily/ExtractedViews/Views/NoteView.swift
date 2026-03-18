//
//  noteView.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct NoteView: View {
    @Binding var entryNotes: String
    
    @Binding var showingNotePopover: Bool
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            EntryOptionView(
                image: "character.circle.fill",
                option: "Note"
            ) {
                TextField("Que se passe-t-il ?", text: $entryNotes, axis: .vertical)

                Spacer()

            } optionAction: {
                showingNotePopover = false
            }

        }
    }
}

#Preview {
    @Previewable
    @State var notes = ""
    
    NoteView(entryNotes: $notes, showingNotePopover: .constant(true))
}
