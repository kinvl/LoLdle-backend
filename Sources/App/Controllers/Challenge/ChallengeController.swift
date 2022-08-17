//
//  ChallengeController.swift
//  
//
//  Created by Krzysztof Kinal on 19/08/2022.
//

import Vapor

final class ChallengeController: RouteCollection {
    private let championChallengeRoutes: ChampionChallengeController
    
    // MARK: - Initialization
    init(championChallengeRoutes: ChampionChallengeController) {
        self.championChallengeRoutes = championChallengeRoutes
    }
    
    // MARK: - RouteCollection
    func boot(routes: RoutesBuilder) throws {
        try routes.group(Path.challenge) { challenge in
            try challenge.register(collection: championChallengeRoutes)
        }
    }
}
