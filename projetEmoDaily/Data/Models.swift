//
//  Models.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 05/03/2026.
//

import Foundation

// modèle de l'utilisateur
struct User: Identifiable {
    let id = UUID()
    
    // (pour création d'un compte)
    let username: String // unique
    let password: String
    let email: String // unique
    
    // (pour profil)
    let image: String
    let age: Int // >= 15
    
    // (pour données relatives à son journal, ses quêtes et ses stats)
    let entries: [Entry]?
    let challenges: [Challenge]?
    let stamps: [Stamp]?
    
    // (init si classe)
}

// modèle de l'entrée d'un User
struct Entry: Identifiable {
    let id = UUID()
    
    // (obligatoire dans l'entrée)
    let date: Date
    let emotion: Emotion
    
    // (optionnels dans l'entrée)
    let notes: String?
    let image: String?
    
    /* (en standby, possiblement trop compliqué?)
    let record: AVAudioRecorder?
    let draw: UIImage? // NSImage? dérivé de la struct "PKDrawing"
    let music: //API MusicKit ou AppleMusic avec AppleDeveloper key
    let gif: String? // URL du GIF ou API Giphy
    */
    
    // (pour niveaux des jauges de santé)
    let anxiety: AnxietyLevel
    let energy: EnergyLevel
    let appetite: AppetiteLevel
    let sleep: SleepLevel

    // (init si classe)
}

// enums pour l'entrée d'un User
enum Emotion: String, CaseIterable {
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
}

enum AnxietyLevel: String, CaseIterable {
    case verylow = "tout roule"
    case low = "ça va"
    case neutral = "pas vraiment"
    case high = "anxieux.se"
    case veryhigh = "beaucoup"
}

enum EnergyLevel: String, CaseIterable {
    case verylow = "vidé.e"
    case low = "fatigué.e"
    case neutral = "normal"
    case high = "bien"
    case veryhigh = "chargé.e à bloc"
}

enum AppetiteLevel: String, CaseIterable {
    case low = "absolument pas"
    case neutral = "un peu"
    case high = "beaucoup"
}

enum SleepLevel: String, CaseIterable {
    case allnighter = "nuit blanche"
    case insomnia = "insomnie"
    case sleep = "sommeil léger"
    case goodsleep = "nuit complète"
}

// modèle des différentes quêtes d'un User
class Quest {
    let id = UUID()
    
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

// modèle des quêtes de type Challenge
class Challenge: Quest, Identifiable {
    var type: ChallengeType
    var image: String
    var startDate: Date?
    var endDate: Date?
    var isCompleted: Bool
    
    init(title: String, questDescription: String, progress: Int, total: Int, type: ChallengeType, image: String, startDate: Date?, endDate: Date?, isCompleted: Bool) {
        self.type = type
        self.image = image
        self.startDate = startDate
        self.endDate = endDate
        self.isCompleted = isCompleted
        
        super.init(title: title, questDescription: questDescription, progress: progress, total: total)
    }
}

// enum des différentes catégories de Challenge
enum ChallengeType: String {
    case solo = "Individuel"
    case multi = "Collectif"
}

// modèle des quêtes de type Stamp
class Stamp: Quest, Identifiable {
    var level: Int // 0-5
    
    init(title: String, questDescription: String, progress: Int, total: Int, level: Int) {
        self.level = level
        
        super.init(title: title, questDescription: questDescription, progress: progress, total: total)
    }
}
