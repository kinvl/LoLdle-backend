//
//  ChallengesRepository.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Vapor
import Fluent

protocol ChallengesRepository {
    func getChallenge(type: ChallengeType, database: Database) async -> Challenge?
}

extension DatabaseRepository: ChallengesRepository {
    func getChallenge(type: ChallengeType, database: Database) async -> Challenge? {
        return await find(Challenge.self, id: type.id, on: database)
    }
}
