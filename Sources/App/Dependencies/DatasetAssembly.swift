//
//  DatasetAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject

final class DatasetAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Dataset.self) { resolver in
            let championsRepository = resolver.resolve(ChampionsRepository.self)!
            return Dataset(championsRepository: championsRepository)
        }.inObjectScope(.container)
    }
}
