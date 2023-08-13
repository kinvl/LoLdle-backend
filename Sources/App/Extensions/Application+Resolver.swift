//
//  Application+Resolver.swift
//  
//
//  Created by Krzysztof Kinal on 18/07/2023.
//

import Vapor
import Swinject

extension Application {
    var resolver: Resolver {
        if storage[ResolverKey.self] == nil {
            storage[ResolverKey.self] = App.Assembler.init(application: self).assembler.resolver
        }
        
        return storage[ResolverKey.self]!
    }
}

private struct ResolverKey: StorageKey {
    typealias Value = Resolver
}
