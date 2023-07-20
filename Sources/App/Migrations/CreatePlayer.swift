//
//  CreatePlayer.swift
//  
//
//  Created by Krzysztof Kinal on 19/07/2023.
//

import Fluent

struct CreatePlayer: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Player.schema)
            .id()
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Player.schema).delete()
    }
}
