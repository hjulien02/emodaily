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
        quests: questsData
    ),

    User(
        username: "alex",
        password: "password",
        email: "alex@gmail.com",
        image: "default",
        age: 27,
        quests: questsData2
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

// Tableaux de quests
    // pour User1
let questsData: [Quest] = [

    Quest(
        title: "Streak 5 Jours",
        questDescription: "Enregistrez 5 entrées consécutives!",
        progress: 2,
        total: 7
    ),

    Quest(
        title: "15 entrées (Mars)",
        questDescription: "Enregistrez 15 entrées en mars!",
        progress: 5,
        total: 5
    ),

    Quest(
        title: "Artiste dans l’âme",
        questDescription: "Dessinez sur 10 entrées consécutives!",
        progress: 3,
        total: 10
    ),
    
    Quest(
        title: "Challenge gratitude",
        questDescription: "Partager chaque jour quelque chose de positif.",
        progress: 3,
        total: 1000
    ),
    
    Quest(
        title: "Nombre d’entrées",
        questDescription: "Nombre d’entrées totales enregistrées dans l’application. Parce qu’il fait bon de se sentir comme chez soi...",
        progress: 22,
        total: 50
    ),

    Quest(
        title: "Entrées musicales",
        questDescription: "...",
        progress: 4,
        total: 20
    ),

    Quest(
        title: "Challenges complétés",
        questDescription: "...",
        progress: 3,
        total: 5
    )
]

    // Pour User2
let questsData2: [Quest] = [

    Quest(
        title: "Challenge gratitude",
        questDescription: "Partager chaque jour quelque chose de positif.",
        progress: 3,
        total: 1000
    ),
    
    Quest(
        title: "Nombre d’entrées",
        questDescription: "Nombre d’entrées totales enregistrées dans l’application. Parce qu’il fait bon de se sentir comme chez soi...",
        progress: 22,
        total: 50
    ),

    Quest(
        title: "Entrées musicales",
        questDescription: "...",
        progress: 4,
        total: 20
    ),

    Quest(
        title: "quests complétés",
        questDescription: "...",
        progress: 3,
        total: 5
    )
]
