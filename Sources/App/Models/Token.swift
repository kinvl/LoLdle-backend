//
//  Token.swift
//  
//
//  Created by Krzysztof Kinal on 19/07/2023.
//

import Vapor
import Fluent

final class Token: Model, Content {
    static var schema: String = "tokens"
    
    @ID
    var id: UUID?
    
    @Field(key: "value")
    var value: String
    
    @Parent(key: "playerID")
    var player: Player
    
    init() {}
    
    init(id: UUID? = nil, value: String, playerID: Player.IDValue) {
        self.id = id
        self.value = value
        self.$player.id = playerID
    }
    
    final class Public {
        let token: String
        
        init(token: String) {
            self.token = token
        }
    }
}

extension Token.Public: Content {}

extension Token {
    static func generate(for player: Player) throws -> Token {
        let random = [UInt8].random(count: 16).base64
        return try Token(value: random, playerID: player.requireID())
    }
    
    func mapToPublic() -> Token.Public {
        Token.Public(token: self.value)
    }
}

extension Token: ModelTokenAuthenticatable {
    typealias User = Player
    
    static var valueKey = \Token.$value
    static var userKey = \Token.$player
    
    var isValid: Bool {
        true
    }
}
