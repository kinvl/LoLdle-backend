//
//  CreateChallenge.swift
//  
//
//  Created by Krzysztof Kinal on 19/08/2022.
//

import FluentKit

struct CreateChallenge: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Challenge.schema)
            .field(.id, .int, .identifier(auto: true))
            .field(.challengeType, .string, .required)
            .field(.challengeSecret, .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Challenge.schema).delete()
    }
}
