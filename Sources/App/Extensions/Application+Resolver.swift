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
        App.Assembler.init(application: self).assembler.resolver
    }
}
