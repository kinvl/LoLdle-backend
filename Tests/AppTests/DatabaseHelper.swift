//
//  DatabaseHelper.swift
//  
//
//  Created by Krzysztof Kinal on 07/09/2022.
//

@testable import App
import FluentKit
import SQLKit

final class DatabaseHelper {
    static var tables: [String] {[
        Challenge.schema, Champion.schema, Statistic.schema
    ]}
    
    static var statisticRows: [Statistic] {[
        Statistic(id: ChallengeType.champion.id, challengeType: ChallengeType.champion.rawValue, completions: 0),
        Statistic(id: ChallengeType.quote.id, challengeType: ChallengeType.quote.rawValue, completions: 1),
        Statistic(id: ChallengeType.ability.id, challengeType: ChallengeType.ability.rawValue, completions: 2),
        Statistic(id: ChallengeType.splash.id, challengeType: ChallengeType.splash.rawValue, completions: 3)
    ]}
    
    static var championRows: [Champion] {[
        Champion(id: 0, name: "Yuumi", gender: "female", position: ["support"], species: ["cat", "rat"], resource: "health", rangeType: "ranged", region: ["bandleCity"], releaseYear: 2020),
        Champion(id: 1, name: "Lulu", gender: "male", position: ["top", "bot"], species: ["unknown"], resource: "mana", rangeType: "melee", region: ["shadowIsles", "blessedIsles"], releaseYear: 2000)
    ]}
    
    static var challengeRows: [Challenge] {[
        Challenge(id: ChallengeType.champion.id, challengeType: ChallengeType.champion.rawValue, challengeSecret: "Yuumi"),
        Challenge(id: ChallengeType.quote.id, challengeType: ChallengeType.quote.rawValue, challengeSecret: "Lulu"),
        Challenge(id: ChallengeType.ability.id, challengeType: ChallengeType.ability.rawValue, challengeSecret: "Kog'Maw"),
        Challenge(id: ChallengeType.splash.id, challengeType: ChallengeType.splash.rawValue, challengeSecret: "Twitch")
    ]}
    
    static func setupDefaultTestTables(inDatabase database: Database) throws {
        try statisticRows.forEach { try $0.create(on: database).wait() }
        try championRows.forEach { try $0.create(on: database).wait() }
        try challengeRows.forEach { try $0.create(on: database).wait() }
    }
    
    static func deleteRowsFromTables(inDatabase database: Database) throws {
        try tables.forEach { table in
            try (database as? SQLDatabase)?
                .delete(from: table)
                .run()
                .wait()
        }
    }
}
