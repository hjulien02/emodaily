//
//  EntryModalView.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 16/03/2026.
//

import SwiftUI


//enum AnxietyLevel: String, CaseIterable, Identifiable, Codable {
//    var id: RawValue { rawValue }
//
//    case verylow = "tout roule"
//    case low = "ça va"
//    case neutral = "pas vraiment"
//    case high = "anxieux.se"
//    case veryhigh = "beaucoup"
//
//    func getSymbol() -> String {
//        switch self {
//        case .verylow:
//            "sun.max.fill"
//        case .low:
//            "cloud.sun.fill"
//        case .neutral:
//            "cloud.fill"
//        case .high:
//            "cloud.rain.fill"
//        case .veryhigh:
//            "cloud.bolt.rain.fill"
//        }
//    }
//}

struct EntryModal: View {
    
    let entry: Entry
    let today = Date()
    
    @Binding var dismissModal: Bool
    
    var body: some View {
        
        let daysDifference = Calendar.current.dateComponents([.day], from: entry.date, to: today)
        
        ZStack{
            
            Color.bg.ignoresSafeArea()
            
            VStack{
                
                HStack{
                    Text(entry.date.formatted(.dateTime.day().month(.wide).year()))
                        .font(.system(size: 24))
                        .bold()
                }
                .padding()
                
                VStack{
                    Text(entry.emotion.getEmoji())
                        .padding(8)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text(entry.emotion.rawValue)
                }
                
                Button {
                    dismissModal.toggle()
                } label: {
                    Text("Annuler")
                }
                .frame(maxWidth: .infinity)
                //.background(.)
                

            }///end VStack
        }

    }
}

#Preview {
    EntryModal(
            entry: Entry(
                date: Date(),
                emotion: .anger,
                notes: "une note",
                image: nil,
                anxiety: .low,
                energy: .high,
                appetite: .low,
                sleep: .allnighter
            ),
            dismissModal: .constant(false)
        )
}
