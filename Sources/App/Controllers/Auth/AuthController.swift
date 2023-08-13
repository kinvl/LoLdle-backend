//
//  AuthController.swift
//  
//
//  Created by Krzysztof Kinal on 20/07/2023.
//

import Vapor

final class AuthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("authme", use: authenticate)
    }
    
    private func authenticate(req: Request) async throws -> Token.Public {
        let player = try req.query.decode(Player.self)
        let token = try Token.generate(for: player)
        
        try await player.save(on: req.db)
        try await token.save(on: req.db)
        
        return token.mapToPublic()
    }
}
