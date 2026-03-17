//
//  EntriesViewModel.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class EntriesViewModel {
    // initialisation clé API + URL AirTable
    private let apiKey: String =
        "api"
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appwe8Hf6wrPvRIR1/Entry"
    )!

    func fetchEntryByID(id: String) async throws -> Entry {
        let newURL = URL(
            string: "https://api.airtable.com/v0/appwe8Hf6wrPvRIR1/Entry/\(id)"
        )!

        // requête
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField: "Authorization"
        )

        do {
            // récupère et stocke les données
            let (data, _) = try await URLSession.shared.data(for: request)

            // décodage JSON
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")

            decoder.dateDecodingStrategy = .formatted(formatter)

            let decoded = try decoder.decode(EntryRecord.self, from: data)
            return decoded.fields
        } catch {
            print("Échec du décodage: \(error)")
            throw error
        }
    }

    func createNewEntry(
        date: Date,
        emotion: Emotion,
        notes: String?,
        image: [Attachment]?,
        anxiety: AnxietyLevel,
        energy: EnergyLevel,
        appetite: AppetiteLevel,
        sleep: SleepLevel,
        user: [String]
    ) async throws -> Entry {
        //entrée à ajouter
        let entry = Entry(
            date: date,
            emotion: emotion,
            notes: notes,
            image: image,
            anxiety: anxiety,
            energy: energy,
            appetite: appetite,
            sleep: sleep,
            user: user
        )

        // encocodage JSON
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        encoder.dateEncodingStrategy = .formatted(formatter)

        let body = NewEntry(fields: entry)
        let encoded = try encoder.encode(body)

        // requête
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField: "Authorization"
        )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encoded

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)

            let decoded = try decoder.decode(EntryRecord.self, from: data)
            return decoded.fields
        } catch {
            print("Échec du décodage Création de l'entrée: \(error)")
            throw error
        }
    }
}

