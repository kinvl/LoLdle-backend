//
//  Assembler.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject

/** Application dependency manager. Any assembly to be registered to a container should go into the static `assembler` property. */
final class Assembler {
    @MainActor
    static let assembler: Swinject.Assembler = {
        return Swinject.Assembler([
            DatabaseRepositoryAssembly(),
            ChallengeControllerAssembly(),
            ChampionChallengeControllerAssembly(),
            DataControllerAssembly(),
            DatasetAssembly(),
            StatisticsControllerAssembly()
        ])
    }()
}
