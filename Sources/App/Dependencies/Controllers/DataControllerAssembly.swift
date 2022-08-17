//
//  DataControllerAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject

final class DataControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DataController.self) { resolver in
            let championsRepository = resolver.resolve(ChampionsRepository.self)!
            let dataRepository = resolver.resolve(DataRepository.self)!
            return DataController(championsRepository: championsRepository, dataRepository: dataRepository)
        }
    }
}
