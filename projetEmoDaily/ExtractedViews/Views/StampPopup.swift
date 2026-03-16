//
//  StampPopup.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 13/03/2026.
//

import SwiftUI

struct StampPopup: View {
    let stamp: Stamp
    let onClose: () -> Void
    let nextIndex: () -> Void
    let prevIndex: () -> Void

    // contrôle l'affichage des flèches
    let hasPrev: Bool
    let hasNext: Bool

    // barre de progression
    let barWidth: CGFloat = 250
    var progressBar: CGFloat {
        CGFloat(stamp.progress) / CGFloat(stamp.total)
    }
    var ratio: CGFloat {
        min(progressBar, 1)
    }

    var body: some View {
        ZStack {
            // quitte le popup lorsqu'on tape sur le fond
            Color("text").opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    onClose()
                }

            VStack {
                // titre / navigation
                HStack {

                    Button {
                        prevIndex()
                    } label: {
                        Text("<")
                            .font(.system(size: 20))
                            .bold()
                    }
                    .opacity(hasPrev ? 1 : 0)
                    .disabled(!hasPrev)

                    Spacer()
                    Text(stamp.title)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)
                    Button {
                        nextIndex()
                    } label: {
                        Text(">")
                            .font(.system(size: 20))
                            .bold()
                    }
                    .opacity(hasNext ? 1 : 0)
                    .disabled(!hasNext)
                }
                .padding(.init(top: 15, leading: 15, bottom: 7.5, trailing: 15))

                // description
                Text(stamp.questDescription)
                    .font(.system(size: 18))
                    .frame(maxWidth: 400, alignment: .leading)
                    .padding()
                    .padding(
                        .init(top: 7.5, leading: 15, bottom: 7.5, trailing: 15)
                    )

                // barre de progression
                HStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: barWidth, height: 14)
                            .foregroundStyle(Color.text.opacity(0.2))
                        // superposer un RoundedRectangle montrant la progression
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: barWidth * ratio, height: 14)
                            .foregroundStyle(Color.green4)
                    }
                    Text("\(stamp.progress)/\(stamp.total)")
                        .bold()
                        .frame(maxWidth: 60)
                }
                .frame(maxWidth: .infinity)

                // tampon
                HStack(spacing: 15) {
                    ForEach(0..<5) { i in
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color.text.opacity(0.3))
                                    .frame(maxWidth: 64)
                                // tampon si complété (level)
                                if stamp.level > i {
                                    Image("stamp")
                                        .resizable()
                                        .scaledToFit()
                                }

                                // affiche un cercle pointillé pour l'objectif suivant
                                if i == stamp.level {
                                    Circle()
                                        .stroke(
                                            style: StrokeStyle(
                                                lineWidth: 5,
                                                dash: [2.5, 2.5]
                                            )
                                        )
                                        .frame(width: 29)
                                }
                            }

                            // affiche les paliers complété et celui à venir (cache les autres)
                            Text(
                                i <= stamp.level ? "\(stamp.levelGoals[i])" : ""
                            )
                            .frame(maxWidth: 50, maxHeight: 18)
                        }
                        .padding(i % 2 == 0 ? .top : .bottom)
                    }
                }
                .padding()
            }
            .foregroundStyle(Color.text)
            .background(Color.bg)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
        }
    }
}

#Preview {
    StampPopup(
        stamp: Stamp(
            id: "1",
            title: "Nombre d'entrées",
            questDescription:
                "Nombre d’entrées totales enregistrées dans l’application. Parce qu’il fait bon de se sentir comme chez soi...",
            progress: 22,
            total: 50,
            questType: "stamp",
            level: 2,
            levelGoals: [3, 20, 50, 100, 300]
        ),
        onClose: {},
        nextIndex: {},
        prevIndex: {},
        hasPrev: false,
        hasNext: true
    )
}
