//
//  UsersViewModel.swift
//  projetEmoDaily
//
//  Created by Apprenent 151 on 10/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class UsersViewModel {
    // initialisation clé API + URL AirTable
    private let apiKey: String = ""
    private let baseURL = URL(string: "https://api.airtable.com/v0/appwe8Hf6wrPvRIR1/User")!
    var users: [User] = []
    var connectedUser: User = User(username: "", password: "", email: "", image: "", age: 15, entries: [], quests: [])
    var entries: [Entry] = []
    var quests: [Quest] = []
    
    func fetchUsers() async throws {
        // requête
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        // récupère et stocke les données
        let (data, _) = try await URLSession.shared.data(for: request)

        // décodage JSON
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(UsersResponse.self, from: data)
            let users = decoded.records.map { $0.fields }
            self.users = users
            self.connectedUser = users[0]
        } catch {
            print("Échec du décodage: \(error)")
            throw error
        }
    }
}
