//
//  Database.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 05/03/2026.
//

import Foundation

// Tableau de Users
let usersData: [User] = [

    User(
        username: "luna",
        password: "123456",
        email: "luna@gmail.com",
        image: "luna",
        age: 22,
        entries: entriesData,
        challenges: challengesData,
        stamps: stampsData
    ),

    User(
        username: "alex",
        password: "password",
        email: "alex@gmail.com",
        image: nil,
        age: 27,
        entries: nil,
        challenges: challengesMultiData,
        stamps: stampsData2
    )
]

// Tableau d’Entries
let entriesData: [Entry] = [

    Entry(
        date: Date(),
        emotion: .happiness,
        notes: "Très bonne journée, balade au soleil.",
        image: "happy_day",
        anxiety: .verylow,
        energy: .high,
        appetite: .high,
        sleep: .goodsleep
    ),

    Entry(
        date: Date(),
        emotion: .tired,
        notes: "Journée longue au travail.",
        image: nil,
        anxiety: .neutral,
        energy: .low,
        appetite: .neutral,
        sleep: .sleep
    ),

    Entry(
        date: Date(),
        emotion: .sad,
        notes: "Un peu de baisse de moral aujourd'hui.",
        image: "rainy_day",
        anxiety: .high,
        energy: .verylow,
        appetite: .low,
        sleep: .insomnia
    ),

    Entry(
        date: Date(),
        emotion: .good,
        notes: "Séance de sport et lecture.",
        image: "sport_day",
        anxiety: .low,
        energy: .high,
        appetite: .high,
        sleep: .goodsleep
    )
]

// Tableaux de Challenges
    // pour User1
let challengesData: [Challenge] = [

    Challenge(
        title: "Streak 5 Jours",
        questDescription: "Enregistrez 5 entrées consécutives!",
        progress: 2,
        total: 7,
        challengeType: .solo,
        image: "breathing",
        startDate: Date(),
        endDate: nil,
        isCompleted: false
    ),

    Challenge(
        title: "15 entrées (Mars)",
        questDescription: "Enregistrez 15 entrées en mars!",
        progress: 5,
        total: 5,
        challengeType: .solo,
        image: "walk",
        startDate: Date(),
        endDate: Date(),
        isCompleted: true
    ),

    Challenge(
        title: "Artiste dans l’âme",
        questDescription: "Dessinez sur 10 entrées consécutives!",
        progress: 3,
        total: 10,
        challengeType: .solo,
        image: "gratitude",
        startDate: Date(),
        endDate: nil,
        isCompleted: false
    ),
    
    Challenge(
        title: "Challenge gratitude",
        questDescription: "Partager chaque jour quelque chose de positif.",
        progress: 3,
        total: 1000,
        challengeType: .multi,
        image: "gratitude",
        startDate: Date(),
        endDate: nil,
        isCompleted: false
    )
]

    // Pour User2
let challengesMultiData: [Challenge] = [

    Challenge(
        title: "Challenge gratitude",
        questDescription: "Partager chaque jour quelque chose de positif.",
        progress: 1,
        total: 1000,
        challengeType: .multi,
        image: "gratitude",
        startDate: Date(),
        endDate: nil,
        isCompleted: false
    )
]

// Tableau de Stamps
    //Pour User1
let stampsData: [Stamp] = [

    Stamp(
        title: "Nombre d’entrées",
        questDescription: "Nombre d’entrées totales enregistrées dans l’application. Parce qu’il fait bon de se sentir comme chez soi...",
        progress: 22,
        total: 50,
        level: 2
    ),

    Stamp(
        title: "Entrées musicales",
        questDescription: "...",
        progress: 4,
        total: 20,
        level: 2
    ),

    Stamp(
        title: "Challenges complétés",
        questDescription: "...",
        progress: 3,
        total: 5,
        level: 3
    )
]

    //Pour User2
let stampsData2: [Stamp] = [

    Stamp(
        title: "Nombre d’entrées",
        questDescription: "Nombre d’entrées totales enregistrées dans l’application. Parce qu’il fait bon de se sentir comme chez soi...",
        progress: 22,
        total: 50,
        level: 2
    ),

    Stamp(
        title: "Entrées musicales",
        questDescription: "...",
        progress: 4,
        total: 20,
        level: 2
    ),

    Stamp(
        title: "Challenges complétés",
        questDescription: "...",
        progress: 3,
        total: 5,
        level: 3
    )
]
