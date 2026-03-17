//
//  QuestsViewModel.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class QuestsViewModel {
    // initialisation clé API + URL AirTable
    private let apiKey: String = ""
    private let baseURL = URL(string: "https://api.airtable.com/v0/appwe8Hf6wrPvRIR1/Quest")!
    var quests: [Quest] = []
    
    func fetchQuestByID(id: String) async throws -> Quest {
        let newURL = URL(string: "\(baseURL)/\(id)")!
        
        // requête
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            // récupère et stocke les données
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // décodage JSON
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")

            decoder.dateDecodingStrategy = .formatted(formatter)
            let decoded = try decoder.decode(QuestRecord.self, from: data)
            return convertQuest(from: decoded)
        } catch {
            print("Échec du décodage: quest")
            throw error
        }
    }
}
