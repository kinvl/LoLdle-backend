//
//  Player.swift
//  
//
//  Created by Krzysztof Kinal on 19/07/2023.
//

import Vapor
import Fluent

final class Player: Model, Authenticatable {
    static let schema = "players"
    
    @ID
    var id: UUID?
    
    @OptionalChild(for: \.$player)
    var token: Token?
}

struct PlayerAuthenticator: AsyncBearerAuthenticator {
    func authenticate(bearer: BearerAuthorization, for request: Request) async throws {
        if let player = try await Player.query(on: request.db).with(\.$token).filter(\.token!.$value == bearer.token).first() {
            request.auth.login(player)
        }
    }
}

extension Player: Content {
}
