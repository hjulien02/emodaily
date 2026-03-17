//
//  DateView.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 17/03/2026.
//

import SwiftUI

struct DateView: View {

    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        
        let start = calendar.date(byAdding: .day, value: -7, to: Date.now)!
        let end = calendar.startOfDay(for: Date.now)
            .addingTimeInterval(86399) // pour indiquer jusqu'à 23:59:59
        
        return start...end
    }
    
    @Binding var showingDatePicker: Bool
    @Binding var selectedDate: Date

    var body: some View {
        VStack(spacing: 24) {
            Text("Sélectionne une date")
                .font(.system(size: 20))
                .bold()
                .padding(.top, 16)
            VStack{
                DatePicker(
                    "Sélectionne la date",
                    selection: $selectedDate,
                    in: dateRange,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .labelsHidden()
                .accentColor(.green4)
                .environment(\.locale, Locale(identifier: "fr_FR"))
            }
            .frame(height: 350)

            Button {
                showingDatePicker = false
            } label: {
                Text("OK")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(.green4)
                            .stroke(.green15.opacity(0.4), lineWidth: 2)
                    )
                    .foregroundStyle(Color.white)
                    .bold()
            }

        }
        .padding()
        .background(Color.background)
        .cornerRadius(24)
        .shadow(radius: 12)
        .padding()
    }
}



#Preview {
    @Previewable @State var showingPicker: Bool = false
    @Previewable @State var selectedDate: Date = Calendar.current.date(
           byAdding: .day, value: -3, to: Date.now) ?? Date.now

    DateView(showingDatePicker: $showingPicker, selectedDate: $selectedDate)
}
