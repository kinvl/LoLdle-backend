//
//  CronJobs.swift
//  
//
//  Created by Krzysztof Kinal on 05/09/2022.
//

import Vapor
import VaporCron

struct CronJob {
    static let dailyExpression = CronExpression.expressionFor(hour: 22, minute: 0)
    
    public struct RefreshDailyChallenges: AsyncVaporCronSchedulable {
        public typealias T = Void
        static var expression: String { dailyExpression }
        
        public static func task(on application: Application) async throws {
            let repository = Assembler.assembler.resolver.resolve(ChallengesRepository.self)!
            let dataset = Assembler.assembler.resolver.resolve(Dataset.self)!
            let database = application.db
            guard let challenge = await repository.getChallenge(type: .champion, database: database),
                  let champion = dataset.champions.randomElement()
            else { throw Abort(.internalServerError) }
            
            challenge.challengeSecret = champion
            
            try await challenge.save(on: database)
        }
    }
    
    struct ResetDailyStatistics: AsyncVaporCronSchedulable {
        typealias T = Void
        static var expression: String { dailyExpression }
        
        public static func task(on application: Application) async throws {
            let repository = Assembler.assembler.resolver.resolve(StatisticsRepository.self)!
            let database = application.db
            guard let statistics = await repository.getAllStatistics(database: database) else { throw Abort(.internalServerError) }
            
            try await statistics.concurrentForEach { statistic in
                statistic.completions = 0
                
                try await statistic.save(on: database)
            }
        }
    }
}
