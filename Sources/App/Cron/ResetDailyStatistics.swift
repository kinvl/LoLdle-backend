//
//  ResetDailyStatistics.swift
//  
//
//  Created by Krzysztof Kinal on 18/07/2023.
//

import Vapor
import VaporCron

extension CronJob {
    struct ResetDailyStatistics: AsyncVaporCronSchedulable {
        typealias T = Void
        static var expression: String { dailyExpression }
        
        public static func task(on application: Application) async throws {
            let repository = application.resolver.resolve(StatisticsRepository.self)!
            let database = application.db
            
            guard let statistics = await repository.getAllStatistics(database: database) else { throw Abort(.internalServerError) }
            
            try await statistics.concurrentForEach { statistic in
                statistic.completions = 0
                
                try await statistic.save(on: database)
            }
        }
    }
}
