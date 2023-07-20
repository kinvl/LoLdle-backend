//
//  MainAssembly.swift
//  
//
//  Created by Krzysztof Kinal on 18/07/2023.
//

import Swinject
import Vapor
import Fluent

final class MainAssembly: Assembly {
    private let application: Application
    
    init(application: Application) {
        self.application = application
    }
    
    func assemble(container: Container) {
        container.register(Database.self) { _ in
            self.application.db
        }
    }
}
