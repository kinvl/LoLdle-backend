//
//  CreateStatistics.swift
//  
//
//  Created by Krzysztof Kinal on 19/08/2022.
//

import FluentKit

struct CreateStatistics: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Statistic.schema)
            .field(.id, .int, .identifier(auto: true))
            .field(.challengeType, .string, .required)
            .field(.completions, .int, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Statistic.schema).delete()
    }
}
