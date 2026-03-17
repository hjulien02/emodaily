//
//  Models.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 05/03/2026.
//

import Foundation
import Observation
import SwiftUI

struct UsersResponse: Codable {
    let records: [UserRecord]
}

struct UserRecord: Codable {
    let id: String
    let fields: User
}

// modèle de l'utilisateur
struct User: Identifiable, Codable {
    let id = UUID()

    // (pour création d'un compte)
    let username: String  // unique
    let password: String
    let email: String  // unique

    // (pour profil)
    let image: String
    let age: Int  // >= 15

    // (pour données relatives à son journal, ses quêtes et ses stats)
    let entries: [String]?
    let quests: [String]?

    private enum CodingKeys: String, CodingKey {
        case username
        case password
        case email
        case image
        case age
        case entries
        case quests
    }

    init(
        username: String,
        password: String,
        email: String,
        image: String,
        age: Int,
        entries: [String] = [],
        quests: [String] = []
    ) {
        self.username = username
        self.password = password
        self.email = email
        self.image = image
        self.age = age
        self.entries = entries
        self.quests = quests
    }
}

struct EntriesResponse: Codable {
    let records: [EntryRecord]
}

struct EntryRecord: Codable {
    let id: String
    let fields: Entry
}

struct NewEntry: Codable {
    let fields: Entry
}

// modèle de l'entrée d'un User
class Entry: Identifiable, Codable {
    // (obligatoire dans l'entrée)
    var date: Date
    var emotion: Emotion

    // (optionnels dans l'entrée)
    var notes: String?
    var image: [Attachment]?

    /* (en standby, possiblement trop compliqué?)
    let record: AVAudioRecorder?
    let draw: UIImage? // NSImage? dérivé de la struct "PKDrawing"
    let music: //API MusicKit ou AppleMusic avec AppleDeveloper key
    let gif: String? // URL du GIF ou API Giphy
    */

    // (pour niveaux des jauges de santé)
    var anxiety: AnxietyLevel
    var energy: EnergyLevel
    var appetite: AppetiteLevel
    var sleep: SleepLevel

    // (pour renseigner l'utilisateur lié à l'entrée)
    let user: [String]
    
    private enum CodingKeys: String, CodingKey {
        case date = "Date"
        case emotion = "Emotion"
        case notes = "Notes"
        case image = "Image"
        case anxiety = "AnxietyLevel"
        case energy = "EnergyLevel"
        case appetite = "AppetiteLevel"
        case sleep = "SleepLevel"
        case user = "User"
    }

    init(
        date: Date,
        emotion: Emotion,
        notes: String? = "",
        image: [Attachment]? = [],
        anxiety: AnxietyLevel,
        energy: EnergyLevel,
        appetite: AppetiteLevel,
        sleep: SleepLevel,
        user: [String]
    ) {
        self.date = date
        self.emotion = emotion
        self.notes = notes
        self.image = image
        self.anxiety = anxiety
        self.energy = energy
        self.appetite = appetite
        self.sleep = sleep
        self.user = user
    }
    
    func uploadImageAsAttachment(_ image: UIImage) async throws -> Attachment {
        let url = try await uploadImage(image)
        
        return Attachment(
            id: nil,
            width: Int(image.size.width),
            height: Int(image.size.height),
            url: url,
            filename: "new_image.jpg",
            size: image.jpegData(compressionQuality: 0.8)?.count,
            type: "image/jpeg",
            thumbnails: nil
        )
    }
}

struct Attachment: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: URL
    let filename: String?
    let size: Int?
    let type: String?
    let thumbnails: Thumbnails?
}

struct Thumbnails: Codable {
    let small: ThumbnailVariant?
    let large: ThumbnailVariant?
    let full: ThumbnailVariant?
}

struct ThumbnailVariant: Codable {
    let url: URL
    let width: Int?
    let height: Int?
}

struct CloudinaryResponse: Codable {
    let secure_url: String
}

// enums pour l'entrée d'un User
enum Emotion: String, CaseIterable, Identifiable, Codable {
    var id: RawValue { rawValue }

    case anger = "colère"
    case boredom = "ennui"
    case happiness = "joie"
    case depressive = "déprime"
    case tired = "fatigue"
    case boss = "boss"
    case good = "bien"
    case sad = "triste"
    case sorrow = "chagrin"
    case sick = "malade"
    case unchosen = ""

    func getEmoji() -> String {
        switch self {
        case .anger:
            "😤"
        case .boredom:
            "😑"
        case .happiness:
            "😃"
        case .depressive:
            "🫩"
        case .tired:
            "😴"
        case .boss:
            "😎"
        case .good:
            "🙂"
        case .sad:
            "😥"
        case .sorrow:
            "😞"
        case .sick:
            "🤒"
        case .unchosen:
            "❌"
        }
    }
}

enum AnxietyLevel: String, CaseIterable, Identifiable, Codable {
    var id: RawValue { rawValue }

    case verylow = "tout roule"
    case low = "ça va"
    case neutral = "pas vraiment"
    case high = "anxieux.se"
    case veryhigh = "beaucoup"

    func getSymbol() -> String {
        switch self {
        case .verylow:
            "sun.max.fill"
        case .low:
            "cloud.sun.fill"
        case .neutral:
            "cloud.fill"
        case .high:
            "cloud.rain.fill"
        case .veryhigh:
            "cloud.bolt.rain.fill"
        }
    }
}

enum EnergyLevel: String, CaseIterable, Identifiable, Codable {
    var id: RawValue { rawValue }

    case verylow = "vidé.e"
    case low = "fatigué.e"
    case neutral = "normal"
    case high = "bien"
    case veryhigh = "chargé.e à bloc"

    func getSymbol() -> String {
        switch self {
        case .verylow:
            "battery.0percent"
        case .low:
            "battery.25percent"
        case .neutral:
            "battery.50percent"
        case .high:
            "battery.75percent"
        case .veryhigh:
            "battery.100percent"
        }
    }
}

enum AppetiteLevel: String, CaseIterable, Identifiable, Codable {
    var id: RawValue { rawValue }

    case low = "absolument pas"
    case neutral = "un peu"
    case high = "beaucoup"

    func getSymbol() -> String {
        switch self {
        case .low:
            "circle"
        case .neutral:
            "circle.lefthalf.filled"
        case .high:
            "circle.fill"
        }
    }
}

enum SleepLevel: String, CaseIterable, Codable {
    var id: RawValue { rawValue }

    case allnighter = "nuit blanche"
    case insomnia = "insomnie"
    case sleep = "sommeil léger"
    case goodsleep = "nuit complète"

    func getSymbol() -> String {
        switch self {
        case .allnighter:
            "eye.fill"
        case .insomnia:
            "eye.half.closed.fill"
        case .sleep:
            "bed.double.fill"
        case .goodsleep:
            "moon.zzz.fill"
        }
    }
}

struct QuestsResponse: Codable {
    let records: [QuestRecord]
}

struct QuestRecord: Identifiable, Codable {
    let id: String
    let fields: QuestFields
}

struct QuestFields: Codable {
    let title: String
    let questDescription: String
    let progress: Int
    let total: Int
    let questType: String

    let challengeType: ChallengeType?
    let image: String?
    let startDate: Date?
    let endDate: Date?
    let isCompleted: Bool?

    let level: Int?
}

// modèle des différentes quêtes d'un User
class Quest: Identifiable {
    var id: String

    var title: String
    var questDescription: String
    var progress: Int
    var total: Int
    var questType: String

    init(
        id: String,
        title: String,
        questDescription: String,
        progress: Int,
        total: Int,
        questType: String
    ) {
        self.id = id
        self.title = title
        self.questDescription = questDescription
        self.progress = progress
        self.total = total
        self.questType = questType
    }
}

func convertQuest(from record: QuestRecord) -> Quest {
    let fields = record.fields
    if (fields.questType == "challenge") {
        return Challenge(id: record.id, title: fields.title, questDescription: fields.questDescription, progress: fields.progress, total: fields.total, questType: fields.questType, challengeType: fields.challengeType ?? .solo, image: fields.image ?? "", isCompleted: fields.isCompleted ?? false)
    } else {
        return Stamp(id: record.id, title: fields.title, questDescription: fields.questDescription, progress: fields.progress, total: fields.total, questType: fields.questType, level: fields.level ?? 0)
    }
}

// modèle des quêtes de type Challenge
class Challenge: Quest {
    var challengeType: ChallengeType
    var image: String
    var startDate: Date?
    var endDate: Date?
    var isCompleted: Bool

    init(
        id: String,
        title: String,
        questDescription: String,
        progress: Int,
        total: Int,
        questType: String,
        challengeType: ChallengeType,
        image: String,
        startDate: Date? = nil,
        endDate: Date? = nil,
        isCompleted: Bool
    ) {
        self.challengeType = challengeType
        self.image = image
        self.startDate = startDate
        self.endDate = endDate
        self.isCompleted = isCompleted
        super.init(
            id: id,
            title: title,
            questDescription: questDescription,
            progress: progress,
            total: total,
            questType: questType
        )
    }
}

// enum des différentes catégories de Challenge
enum ChallengeType: String, Codable {
    var id: RawValue { rawValue }
    case solo = "individuel"
    case multi = "collectif"
}

// modèle des quêtes de type Stamp
class Stamp: Quest {
    var level: Int  // 0-5

    init(
        id: String,
        title: String,
        questDescription: String,
        progress: Int,
        total: Int,
        questType: String,
        level: Int
    ) {
        self.level = level

        super.init(
            id: id,
            title: title,
            questDescription: questDescription,
            progress: progress,
            total: total,
            questType: questType
        )
    }

}

