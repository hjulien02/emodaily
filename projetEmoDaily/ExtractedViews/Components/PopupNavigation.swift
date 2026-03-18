//
//  PopupNavigation.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 18/03/2026.
//

import SwiftUI

struct PopupNavigation: View {

    let nextIndex: () -> Void
    let prevIndex: () -> Void
    let hasPrev: Bool
    let hasNext: Bool
    let title: String

    var body: some View {
        HStack {
            Button {
                prevIndex()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
            }
            .opacity(hasPrev ? 1 : 0)
            .disabled(!hasPrev)

            Spacer()
            Text(title)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity)

            Button {
                nextIndex()
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
            }
            .opacity(hasNext ? 1 : 0)
            .disabled(!hasNext)
        }
    }
}

#Preview {
    PopupNavigation(
        nextIndex: {},
        prevIndex: {},
        hasPrev: true,
        hasNext: true,
        title: "Test titre"
    )
}
