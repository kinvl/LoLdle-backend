//
//  CreateToken.swift
//  
//
//  Created by Krzysztof Kinal on 19/07/2023.
//

import Fluent

struct CreateToken: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Token.schema)
            .id()
            .field("value", .string, .required)
            .field("playerID", .uuid, .required, .references(Player.schema, "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Token.schema).delete()
    }
}
