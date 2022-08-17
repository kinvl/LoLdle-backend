//
//  ChampionChallengeController.swift
//  
//
//  Created by Krzysztof Kinal on 18/08/2022.
//

import Vapor

final class ChampionChallengeController: RouteCollection {
    private let challengesRepository: ChallengesRepository
    private let statisticsRepository: StatisticsRepository
    
    // MARK: - Initialization
    init(challengesRepository: ChallengesRepository, statisticsRepository: StatisticsRepository) {
        self.challengesRepository = challengesRepository
        self.statisticsRepository = statisticsRepository
    }
    
    // MARK: - RouteCollection
    func boot(routes: RoutesBuilder) throws {
        routes.group(Path.champion) { champion in
            champion.get(use: getChampionChallenge)
            champion.post(Path.answer, use: postChampionAnswer)
        }
    }
    
    // MARK: - Private
    private func getChampionChallenge(req: Request) async throws -> Challenge.Public {
        guard let challenge = await challengesRepository.getChallenge(type: .champion, database: req.db)?.mapToPublic() else { throw Abort(.notFound) }
        
        return challenge
    }
    
    private func postChampionAnswer(req: Request) async throws -> Statistic.Public {
        return try await statisticsRepository.incrementStatistic(type: .champion, database: req.db)
    }
}
