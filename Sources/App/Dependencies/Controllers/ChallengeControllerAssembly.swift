//
//  ChallengeControllerAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject

final class ChallengeControllerAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(ChallengeController.self) { resolver in
            let championChallengeRoutes = resolver.resolve(ChampionChallengeController.self)!
            return ChallengeController(championChallengeRoutes: championChallengeRoutes)
        }
    }
}
