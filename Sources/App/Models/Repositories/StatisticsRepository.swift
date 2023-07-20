//
//  StatisticsRepository.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Vapor
import Fluent

protocol StatisticsRepository {
    func getAllStatistics(database: Database) async -> [Statistic]?
    func incrementStatistic(type: ChallengeType, database: Database) async throws -> Statistic.Public
}

class StatisticsRepositoryImpl: DatabaseStorage, StatisticsRepository {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    // MARK: - StatisticsRepository
    func getAllStatistics(database: Database) async -> [Statistic]? {
        return await storage.all(Statistic.self, on: database)
    }
    
    func incrementStatistic(type: ChallengeType, database: Database) async throws -> Statistic.Public {
        guard let statistic = await storage.find(Statistic.self, id: type.id, on: database) else { throw Abort(.internalServerError) }
        statistic.completions += 1
        
        try await statistic.save(on: database)
        
        return statistic.mapToPublic()
    }
}
