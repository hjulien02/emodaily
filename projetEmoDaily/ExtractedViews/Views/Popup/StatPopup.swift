import SwiftUI

struct StatPopup: View {
    let onClose: () -> Void

    let currentIndex: Int
    let nextIndex: () -> Void
    let prevIndex: () -> Void

    // contrôle l'affichage des flèches
    let hasPrev: Bool
    let hasNext: Bool

    var barData: [CGFloat] {
        switch currentIndex {
        case 0: return [3, 4, 2, 4, 2, 0, 0]
        case 1: return [3, 1, 5, 3, 3, 0, 0]
        case 2: return [2, 1, 4, 1, 3, 0, 0]
        case 3: return [4, 2, 5, 2, 4, 0, 0]
        default: return []
        }
    }

    var title: String {
        switch currentIndex {
        case 0: return "Qualité de sommeil"
        case 1: return "Niveau d'appétit"
        case 2: return "Niveau d'énergie"
        case 3: return "Niveau d'anxiété"
        default: return ""
        }
    }

    var body: some View {
        ZStack {
            Color("text").opacity(0.5).ignoresSafeArea()
                .onTapGesture { onClose() }

            VStack(spacing: 30) {
                PopupNavigation(
                    nextIndex: nextIndex,
                    prevIndex: prevIndex,
                    hasPrev: hasPrev,
                    hasNext: hasNext,
                    title: title
                )

                GeometryReader { geo in
                    HStack(alignment: .bottom, spacing: 6) {
                        ForEach(0..<barData.count, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("green4"))
                                .frame(
                                    width: (geo.size.width - CGFloat(
                                        barData.count - 1
                                    ) * 6) / CGFloat(barData.count),
                                    height: (barData[i] / 5) * geo.size.height
                                )
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .frame(height: 200)

                HStack(spacing: 6) {
                    ForEach(0..<barData.count, id: \.self) { i in
                        Text("\(i + 1)")
                            .font(.system(size: 16))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }

                Text("(en jours)")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, -12)
            }
            .padding(20)
            .frame(width: .infinity)
            .background(Color("bg"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 8)
            .padding()
        }
        .foregroundStyle(.text)
    }
}

#Preview {
    StatPopup(
        onClose: {},
        currentIndex: 0,
        nextIndex: {},
        prevIndex: {},
        hasPrev: false,
        hasNext: true
    )
}
