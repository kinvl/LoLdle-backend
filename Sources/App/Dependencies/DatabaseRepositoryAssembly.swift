//
//  DatabaseRepositoryAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject

final class DatabaseRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ChallengesRepository.self) { _ in
            return DatabaseRepository()
        }
        
        container.register(StatisticsRepository.self) { _ in
            return DatabaseRepository()
        }
        
        container.register(ChampionsRepository.self) { _ in
            return DatabaseRepository()
        }
        
        container.register(DataRepository.self) { _ in
            return DatabaseRepository()
        }
    }
}
