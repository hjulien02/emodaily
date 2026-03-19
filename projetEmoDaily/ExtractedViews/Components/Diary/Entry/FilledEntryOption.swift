//
//  entryOption.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 06/03/2026.
//

import SwiftUI

struct FilledEntryOption: View {

    var icon: String
    var notes: String?
    var picture: [Attachment]?

    var body: some View {

        VStack(spacing: 16) {
            if icon == "character.circle.fill" {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 16)

                VStack(alignment: .center) {
                    Text(notes!.lowercased())
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .lineLimit(3, reservesSpace: true)
                        .truncationMode(.tail)
                        .opacity(0.8)
                }
                .frame(maxWidth: .infinity)

            } else if icon == "photo.circle.fill" {
                VStack {
                    if let url = picture?.first?.url {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .background(
                                    RoundedRectangle(cornerRadius: 12).stroke(
                                        .white.opacity(0.4),
                                        lineWidth: 2
                                    )
                                )

                        } placeholder: {
                            ProgressView("Upload en cours...")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(.green4)
                                .bold()
                        }
                    }
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(
            RoundedRectangle(cornerRadius: 20).fill(.green2).stroke(
                .green3.opacity(0.4),
                lineWidth: 2
            )
        )
        .foregroundStyle(Color.text)
    }
}

#Preview {
    FilledEntryOption(
        icon: "character.circle.fill",
        notes: "Mon chat est tombé malade...",
    )
    FilledEntryOption(
        icon: "photo.circle.fill",
        picture: nil,
    )
}
