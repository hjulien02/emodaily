//
//  DiaryViewModel.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 17/03/2026.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class DiaryViewModel: ObservableObject {
    // @Published rend une propriété observable - rafraichi automatiquement toutes les vues qui observent une propriété quand sa valeur change
    @Published var displayedMonth = Date()
    @Published var selectedDate = Date.now

    @Published var entriesList: [Entry] = []

    // Modal
    // Création d'une variable Entrée optionnelle
    @Published var selectedEntry: Entry? = nil

    var vmEntries = EntriesViewModel()
    var vmUser = UsersViewModel()

    // Charge les données de l'API
    func loadData() async {
        
        do {
            try await vmUser.fetchUsers()
        } catch {
            print(error)
        }
                
        if let entries = vmUser.connectedUser.entries {
            var fetchedEntries: [Entry] = []
            for entryId in entries {
                do {
                    let entry = try await vmEntries.fetchEntryByID(id: entryId)
                    fetchedEntries.append(entry)
                } catch {
                    print(error)
                }
            }
            await MainActor.run {
                entriesList = fetchedEntries
            }
        }
    }

}
