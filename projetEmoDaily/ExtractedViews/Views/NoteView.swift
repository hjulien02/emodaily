//
//  noteView.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct NoteView: View {
    var entry: Entry

    @State var note: String = ""

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            EntryOptionView(
                image: "character.circle.fill",
                option: "Note"
            ) {
                Text("Que se passe-t-il ?")
                    .italic()
                    .bold()
                    .opacity(0.5)

                TextField("Ecris ici...", text: $note, axis: .vertical)
                    .font(.system(size: 12))

                Spacer()

            } optionAction: {
                entry.notes = note
            }

        }
    }
}

#Preview {
    NoteView(entry: entriesData[0])
}
