//
//  File.swift
//  
//
//  Created by Krzysztof Kinal on 23/07/2023.
//

import Swinject

final class AuthControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthController.self) { _ in
            AuthController()
        }
    }
}
