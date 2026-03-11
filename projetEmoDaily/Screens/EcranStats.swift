//
//  EcranStats.swift
//  projetEmoDaily
//
//  Created by ThomasJ on 10/03/2026.
//

import SwiftUI


private extension Calendar {
    func weeksOfMonth(for date: Date) -> [[Date?]] {
        var cal = Calendar(identifier: .iso8601)
        cal.locale = Locale(identifier: "fr_FR")

        let comps  = cal.dateComponents([.year, .month], from: date)
        let first  = cal.date(from: comps)!
        let range  = cal.range(of: .day, in: .month, for: first)!
        let last   = cal.date(byAdding: .day, value: range.count - 1, to: first)!

        var startOfGrid = first
        while cal.component(.weekday, from: startOfGrid) != 2 { // 2 = lundi (iso8601)
            startOfGrid = cal.date(byAdding: .day, value: -1, to: startOfGrid)!
        }

        var weeks: [[Date?]] = []
        var current = startOfGrid

        while current <= last {
            var week: [Date?] = []
            for _ in 0..<7 {
                let m = cal.component(.month, from: current)
                week.append(m == comps.month ? current : nil)
                current = cal.date(byAdding: .day, value: 1, to: current)!
            }
            weeks.append(week)
        }
        return weeks
    }
}

private let isoCalendar: Calendar = {
    var c = Calendar(identifier: .iso8601)
    c.locale = Locale(identifier: "fr_FR")
    return c
}()

private let lettresJours = ["L", "M", "M", "J", "V", "S", "D"]

private func formatMois(_ date: Date) -> String {
    let f = DateFormatter()
    f.locale = Locale(identifier: "fr_FR")
    f.dateFormat = "MMMM yyyy"
    return f.string(from: date).capitalized
}

private func formatSemaine(_ index: Int) -> String {
    let num = isoCalendar.component(.weekOfYear,
        from: isoCalendar.date(byAdding: .day, value: index * 7,
            to: isoCalendar.startOfDay(for: Date()))!)
    return "Semaine \(num)"
}

struct EcranStats: View {

    // Référence au mois affiché (toujours le 1er du mois)
    @State private var moisRef: Date = {
        let c = isoCalendar
        let comps = c.dateComponents([.year, .month], from: Date())
        return c.date(from: comps)!
    }()

    // Index de la semaine dans le mois (0 = première semaine)
    @State private var semaineIndex: Int = 0

    // Jour sélectionné
    @State private var jourSelectionne: Date = isoCalendar.startOfDay(for: Date())

    // Semaines calculées pour le mois courant
    private var semaines: [[Date?]] {
        isoCalendar.weeksOfMonth(for: moisRef)
    }

    // Semaine visible
    private var semaineVisible: [Date?] {
        guard semaineIndex < semaines.count else { return [] }
        return semaines[semaineIndex]
    }

    // Numéro ISO de la semaine visible
    private var numeroSemaine: String {
        let joursNonNuls = semaineVisible.compactMap { $0 }
        guard let premier = joursNonNuls.first else { return "" }
        let n = isoCalendar.component(.weekOfYear, from: premier)
        return "Semaine \(n)"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {

                        // MARK: Titre + export
                        HStack {
                            Title(title: "Statistiques")
                            Spacer()
                            Button { } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }

                        
                        CalendrierNavigation(
                            moisRef:          $moisRef,
                            semaineIndex:     $semaineIndex,
                            jourSelectionne:  $jourSelectionne,
                            semaines:         semaines,
                            semaineVisible:   semaineVisible,
                            numeroSemaine:    numeroSemaine
                        )

                        Text("Mood")
                            .font(.title3.weight(.semibold))

                        HStack(spacing: 24) {
                            ZStack {
                                Circle()
                                    .trim(from: 0, to: 0.7)
                                    .stroke(Color("green4"), lineWidth: 20)
                                    .rotationEffect(.degrees(-90))
                                Circle()
                                    .trim(from: 0.7, to: 0.9)
                                    .stroke(Color("green3"), lineWidth: 20)
                                    .rotationEffect(.degrees(-90))
                                Circle()
                                    .trim(from: 0.9, to: 1.0)
                                    .stroke(Color("green2"), lineWidth: 20)
                                    .rotationEffect(.degrees(-90))
                            }
                            .frame(width: 120, height: 120)

                            VStack(alignment: .leading, spacing: 12) {
                                MoodStat(couleur: Color("green2"), pourcentage: "10%", emoji: "😊")
                                MoodStat(couleur: Color("green3"), pourcentage: "20%", emoji: "😐")
                                MoodStat(couleur: Color("green4"), pourcentage: "70%", emoji: "😔")
                            }
                            Spacer()
                        }
                        .padding(.top, 10)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                            Button { } label: { CategorieCard(icone: "bed.double.fill",   label: "Sommeil") }
                            Button { } label: { CategorieCard(icone: "fork.knife",        label: "Appetit") }
                            Button { } label: { CategorieCard(icone: "bolt.fill",         label: "Énergie") }
                            Button { } label: { CategorieCard(icone: "waveform.path.ecg", label: "Anxiété") }
                        }
                        .padding(.top, 30)

                        // MARK: Stats bas
                        HStack(spacing: 10) {
                            StatBottom(label: "Entrées",    valeur: "6")
                            StatBottom(label: "Challenges", valeur: "1")
                            StatBottom(label: "Tampons",    valeur: "19")
                        }
                        .padding(.top, 14)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

// MARK: - Sous-vue navigation calendrier

private struct CalendrierNavigation: View {

    @Binding var moisRef:         Date
    @Binding var semaineIndex:    Int
    @Binding var jourSelectionne: Date

    let semaines:       [[Date?]]
    let semaineVisible: [Date?]
    let numeroSemaine:  String

    // Déplacement vers la semaine précédente (ou le mois précédent)
    private func precedent() {
        if semaineIndex > 0 {
            withAnimation(.easeInOut(duration: 0.25)) {
                semaineIndex -= 1
            }
        } else {
            // Passer au mois précédent, se positionner sur la dernière semaine
            let nouveauMois = isoCalendar.date(byAdding: .month, value: -1, to: moisRef)!
            let nouvellesSemaines = isoCalendar.weeksOfMonth(for: nouveauMois)
            withAnimation(.easeInOut(duration: 0.25)) {
                moisRef = nouveauMois
                semaineIndex = max(0, nouvellesSemaines.count - 1)
            }
        }
    }

    // Déplacement vers la semaine suivante (ou le mois suivant)
    private func suivant() {
        if semaineIndex < semaines.count - 1 {
            withAnimation(.easeInOut(duration: 0.25)) {
                semaineIndex += 1
            }
        } else {
            // Passer au mois suivant, première semaine
            let nouveauMois = isoCalendar.date(byAdding: .month, value: 1, to: moisRef)!
            withAnimation(.easeInOut(duration: 0.25)) {
                moisRef = nouveauMois
                semaineIndex = 0
            }
        }
    }

    var body: some View {
        VStack(spacing: 10) {

            HStack(spacing: 24) {
                Button(action: precedent) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)
                }

                Text(formatMois(moisRef))
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.black)
                    .frame(minWidth: 160)
                    .multilineTextAlignment(.center)

                Button(action: suivant) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
            .frame(maxWidth: .infinity)

            
            HStack(spacing: 6) {
                ForEach(semaines.indices, id: \.self) { i in
                    Capsule()
                        .fill(i == semaineIndex ? Color("green1") : Color("green1").opacity(0.3))
                        .frame(height: 4)
                        .animation(.easeInOut(duration: 0.2), value: semaineIndex)
                }
            }
            .padding(.horizontal, 4)

            Text(numeroSemaine)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                ForEach(Array(semaineVisible.enumerated()), id: \.offset) { index, jourOpt in
                    if let jour = jourOpt {
                        let estSelectionne = isoCalendar.isDate(jour, inSameDayAs: jourSelectionne)
                        let estAujourdhui  = isoCalendar.isDateInToday(jour)
                        let numero         = isoCalendar.component(.day, from: jour)

                        Button {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                jourSelectionne = jour
                            }
                        } label: {
                            VStack(spacing: 2) {
                                Text(lettresJours[index])
                                    .font(.caption.weight(.semibold))
                                Text("\(numero)")
                                    .font(.caption.weight(.bold))
                                    .overlay(
                                        estAujourdhui && !estSelectionne
                                            ? Circle()
                                                .stroke(Color("green4"), lineWidth: 1.5)
                                                .frame(width: 18, height: 18)
                                            : nil
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                estSelectionne
                                    ? Color("green1")
                                    : Color("green1").opacity(0.35)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .foregroundStyle(.black)
                        }
                    } else {
                        // Case vide (jour hors mois)
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("green1").opacity(0.10))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .overlay(
                                Text(" ")
                                    .font(.caption)
                                    .padding(.vertical, 8)
                            )
                    }
                }
            }
        }
    }
}

// MARK: - MoodStat (inchangé)

private struct MoodStat: View {
    let couleur:     Color
    let pourcentage: String
    let emoji:       String

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(couleur)
                .frame(width: 22, height: 22)
            Text(pourcentage)
                .font(.subheadline.weight(.semibold))
            Text(emoji)
        }
    }
}

// MARK: - Preview

#Preview {
    EcranStats()
}
