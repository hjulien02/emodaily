//
//  Models.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 05/03/2026.
//

import Foundation
import Observation

/*
struct UsersResponse: Codable {
    let records: [UserRecord]
}

struct UserRecord: Codable, Identifiable {
    let id: String
    let createdTime: Date
    let fields: User
}
*/

// modèle de l'utilisateur
struct User: Identifiable {
    let id = UUID()

    // (pour création d'un compte)
    let username: String  // unique
    let password: String
    let email: String  // unique

    // (pour profil)
    let image: String
    let age: Int  // >= 15

    // (pour données relatives à son journal, ses quêtes et ses stats)
    let entries: [Entry]
    let quests: [Quest]

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
        entries: [Entry] = [],
        quests: [Quest] = []
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

/*
  struct EntriesResponse: Codable {
  let records: [EntryRecord]
  }

  struct EntryRecord: Codable, Identifiable {
  let id: String
  let createdTime: Date
  let fields: Entry
  }
  */

// modèle de l'entrée d'un User`
@Observable
class Entry: Identifiable {
    var id = UUID()

    // (obligatoire dans l'entrée)
    var date: Date
    var emotion: Emotion

    // (optionnels dans l'entrée)
    var notes: String?
    let image: String?

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

    private enum CodingKeys: String, CodingKey {
        case date = "Date"
        case emotion = "Emotion"
        case notes = "Notes"
        case image = "Image"
        case anxiety = "AnxietyLevel"
        case energy = "EnergyLevel"
        case appetite = "AppetiteLevel"
        case sleep = "SleepLevel"
    }

    init(
        id: UUID = UUID(),
        date: Date,
        emotion: Emotion,
        notes: String?,
        image: String? = "default",
        anxiety: AnxietyLevel,
        energy: EnergyLevel,
        appetite: AppetiteLevel,
        sleep: SleepLevel
    ) {
        self.id = id

        self.date = date
        self.emotion = emotion
        self.notes = notes
        self.image = image
        self.anxiety = anxiety
        self.energy = energy
        self.appetite = appetite
        self.sleep = sleep
    }
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

// modèle des différentes quêtes d'un User
class Quest: Identifiable, Codable {
    var id = UUID()

    var title: String
    var questDescription: String
    var progress: Int
    var total: Int

    init(title: String, questDescription: String, progress: Int, total: Int) {
        self.title = title
        self.questDescription = questDescription
        self.progress = progress
        self.total = total
    }
}

/*
// modèle des quêtes de type Challenge
class Challenge: Quest {
     var challengeType: ChallengeType
     var image: String
     var startDate: Date?
     var endDate: Date?
     var isCompleted: Bool

     init(title: String, questDescription: String, progress: Int, total: Int, challengeType: ChallengeType, image: String, startDate: Date?, endDate: Date?, isCompleted: Bool) {
     self.challengeType = challengeType
     self.image = image
     self.startDate = startDate
     self.endDate = endDate
     self.isCompleted = isCompleted

     super.init(title: title, questDescription: questDescription, progress: progress, total: total)
     }
}

// enum des différentes catégories de Challenge
enum ChallengeType: String, Codable {
    var id: RawValue { rawValue }
    case solo = "Individuel"
    case multi = "Collectif"
}

// modèle des quêtes de type Stamp
class Stamp: Quest {
    var level: Int // 0-5

    init(title: String, questDescription: String, progress: Int, total: Int, level: Int) {
    self.level = level

    super.init(title: title, questDescription: questDescription, progress: progress, total: total)
    }

}
*/
