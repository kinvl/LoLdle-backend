//
//  RepositoryAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Storage.self) { _ in
            DatabaseStorage()
        }
        
        container.register(ChallengesRepository.self) { resolver in
            let storage = resolver.resolve(Storage.self)!
            return ChallengesRepositoryImpl(storage: storage)
        }
        
        container.register(StatisticsRepository.self) { resolver in
            let storage = resolver.resolve(Storage.self)!
            return StatisticsRepositoryImpl(storage: storage)
        }
        
        container.register(ChampionsRepository.self) { resolver in
            let storage = resolver.resolve(Storage.self)!
            return ChampionsRepositoryImpl(storage: storage)
        }
        
        container.register(DataRepository.self) { resolver in
            let storage = resolver.resolve(Storage.self)!
            return DataRepositoryImpl(storage: storage)
        }
    }
}
