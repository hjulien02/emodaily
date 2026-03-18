//  StatPopup.swift
//  projetEmoDaily

import SwiftUI

struct StatPopupSleep: View {
    let onClose: () -> Void

    private let barData: [CGFloat] = [1, 3, 4, 4, 3, 2, 4]

    var body: some View {
        ZStack {
            Color("text").opacity(0.5).ignoresSafeArea()
                .onTapGesture { onClose() }

            VStack(spacing: 30) {

                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    Text("Qualité du sommeil")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.black)
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                }

                GeometryReader { geo in
                    HStack(alignment: .bottom, spacing: 6) {
                        ForEach(0..<barData.count, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("green4"))
                                .frame(
                                    width: (geo.size.width - CGFloat(barData.count - 1) * 6) / CGFloat(barData.count),
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
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }

                Text("Score de sommeil de 3/4 sur 7 jours")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(20)
            .frame(width: 300)
            .background(Color("bg"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 8)
        }
    }
}

#Preview {
    StatPopupSleep(onClose: {})
}
