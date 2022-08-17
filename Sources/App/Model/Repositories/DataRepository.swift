//
//  DataRepository.swift
//  
//
//  Created by Krzysztof Kinal on 10/09/2022.
//

import Vapor
import Fluent

protocol DataRepository {
    func rowCount(inTables tables: [String], database: Database) async -> [String: Int]
}

extension DatabaseRepository: DataRepository {
    func rowCount(inTables tables: [String], database: Database) async -> [String: Int] {
        return await count(tables: tables, on: database)
    }
}
