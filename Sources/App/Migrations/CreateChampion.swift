//
//  CreateChampion.swift
//  
//
//  Created by Krzysztof Kinal on 31/08/2022.
//

import FluentKit

struct CreateChampion: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Champion.schema)
            .field(.id, .int, .identifier(auto: true))
            .field(.name, .string, .required)
            .field(.gender, .string, .required)
            .field(.position, .array(of: .string), .required)
            .field(.species, .array(of: .string), .required)
            .field(.resource, .string, .required)
            .field(.rangeType, .string, .required)
            .field(.region, .array(of: .string), .required)
            .field(.releaseYear, .int, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Champion.schema).delete()
    }
}
