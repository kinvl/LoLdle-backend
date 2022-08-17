//
//  StatisticsController.swift
//  
//
//  Created by Krzysztof Kinal on 19/08/2022.
//

import Vapor

final class StatisticsController: RouteCollection {
    private let statisticsRepository: StatisticsRepository
    
    // MARK: - Initialization
    init(statisticsRepository: StatisticsRepository) {
        self.statisticsRepository = statisticsRepository
    }
    
    // MARK: - RouteCollection
    func boot(routes: RoutesBuilder) throws {
        routes.group(Path.statistics) { statistics in
            statistics.get(use: getAllStatistics)
        }
    }
    
    // MARK: - Private
    private func getAllStatistics(req: Request) async throws -> [Statistic.Public] {
        guard let statistics = await statisticsRepository.getAllStatistics(database: req.db) else { throw Abort(.notFound) }
        let publicStatistics = statistics.map { $0.mapToPublic() }
        
        return publicStatistics
    }
}
