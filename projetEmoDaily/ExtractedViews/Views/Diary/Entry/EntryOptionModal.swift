//
//  EntryOptionModal.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 12/03/2026.
//

import SwiftUI

struct EntryOptionModal<Content: View>: View {
    var image: String
    var option: String

    @ViewBuilder var content: () -> Content
    var optionAction: () -> Void

    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(spacing: 4) {
                    Image(systemName: image)
                        .font(.system(size: 32))

                    Text(option)
                        .font(.custom("Noteworthy", size: 16))
                        .bold()
                }
                .offset(y: 24)

                VStack(alignment: .leading, spacing: 16) {
                    content()
                }
                .padding(24)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.green15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.green4.opacity(0.1), lineWidth: 2)
                        )
                )
                .offset(y: 24)
                
                Spacer()
                
                Button {
                    optionAction()
                } label: {
                    ZStack {
                        Circle()
                            .fill(.green4)
                            .stroke(.green15.opacity(0.4), lineWidth: 2)
                            .frame(maxWidth: 64, maxHeight: 64)

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
    EntryOptionModal(image: "character.circle.fill", option: "Note") {
        Text("Que se passe-t-il ?")
            .italic()
            .bold()
            .opacity(0.5)
    } optionAction: {
        print("Option completed")
    }
}
