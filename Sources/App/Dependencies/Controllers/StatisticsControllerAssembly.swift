//
//  StatisticsControllerAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 04/09/2022.
//

import Swinject

final class StatisticsControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StatisticsController.self) { resolver in
            let statisticsRepository = resolver.resolve(StatisticsRepository.self)!
            return StatisticsController(statisticsRepository: statisticsRepository)
        }
    }
}
