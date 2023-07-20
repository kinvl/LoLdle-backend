//
//  RefreshDailyChallenges.swift
//  
//
//  Created by Krzysztof Kinal on 18/07/2023.
//

import Vapor
import VaporCron

extension CronJob {
    public struct RefreshDailyChallenges: AsyncVaporCronSchedulable {
        public typealias T = Void
        static var expression: String { dailyExpression }
        
        public static func task(on application: Application) async throws {
            let repository = application.resolver.resolve(ChallengesRepository.self)!
            let dataset = application.resolver.resolve(Dataset.self)!
            let database = application.db
            
            guard let challenge = await repository.getChallenge(type: .champion, database: database),
                  let champion = await dataset.drawChampion()
            else { throw Abort(.internalServerError) }
            
            challenge.challengeSecret = champion
            
            try await challenge.save(on: database)
        }
    }
}
