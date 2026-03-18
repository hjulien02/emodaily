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
        case 0: return [2, 4, 1, 0, 2, 3, 4]
        case 1: return [1, 3, 2, 0, 3, 2, 4]
        case 2: return [1, 4, 4, 3, 0, 2, 3]
        case 3: return [1, 3, 4, 4, 3, 0, 4]
        default: return []
        }
    }

    var avg: String {
        String(
            format: "%.2f",
            Double(barData.reduce(0, +)) / Double(barData.count)
        )
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

                Text("Moyenne: \(avg) sur \(barData.count) jours")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
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
