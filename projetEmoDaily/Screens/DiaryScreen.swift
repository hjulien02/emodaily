//
//  DiaryScreen.swift
//  projetEmoDaily
//
//  Created by Apprenant155 on 04/03/2026.
//

import SwiftUI

struct DiaryScreen: View {
    
    @State var vmEntries = EntriesViewModel()
    @State var vmUser = UsersViewModel()
    @State var entriesList: [Entry] = []
    
    func makeFakeEntry() -> Entry {
        return Entry(
            date: Date(),
            emotion: .unchosen,
            anxiety: .low,
            energy: .low,
            appetite: .low,
            sleep: .allnighter,
            user: [""]
        )
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(entriesList) { entry in
                    Text("\(entry.emotion.rawValue)")
                }
                
                NavigationLink("Nouvelle entrée") {
                    NewEntryScreen(vmEntries: $vmEntries, vmUser: $vmUser, entriesList: $entriesList, currentEntry: makeFakeEntry(), selectedEmotion: makeFakeEntry().emotion, note: makeFakeEntry().notes!)
                }
            }.task {
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
    }
}

#Preview {
    DiaryScreen()
}

