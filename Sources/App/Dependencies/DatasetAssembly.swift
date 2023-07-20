//
//  DatasetAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Swinject
import Fluent

final class DatasetAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Dataset.self) { resolver in
            let championsRepository = resolver.resolve(ChampionsRepository.self)!
            let database = resolver.resolve(Database.self)!
            return Dataset(database: database, championsRepository: championsRepository)
        }.inObjectScope(.container)
    }
}
