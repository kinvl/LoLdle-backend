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

class ChallengesRepositoryImpl: ChallengesRepository {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    // MARK: - ChallengesRepository
    func getChallenge(type: ChallengeType, database: Database) async -> Challenge? {
        return await storage.find(Challenge.self, id: type.id, on: database)
    }
}
