//
//  ChampionChallengeControllerAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject

final class ChampionChallengeControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ChampionChallengeController.self) { resolver in
            let challengesRepository = resolver.resolve(ChallengesRepository.self)!
            let statisticsRepository = resolver.resolve(StatisticsRepository.self)!
            return ChampionChallengeController(challengesRepository: challengesRepository, statisticsRepository: statisticsRepository)
        }
    }
}
