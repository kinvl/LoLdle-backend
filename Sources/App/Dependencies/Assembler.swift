//
//  Assembler.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Vapor
import Swinject

class Assembler {
    private let application: Application
    
    lazy var assembler: Swinject.Assembler = {
        .init([
            MainAssembly(application: application),
            RepositoryAssembly(),
            ChallengeControllerAssembly(),
            ChampionChallengeControllerAssembly(),
            DataControllerAssembly(),
            DatasetAssembly(),
            StatisticsControllerAssembly()
        ])
    }()
    
    init(application: Application) {
        self.application = application
    }
}
