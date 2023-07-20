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

class DataRepositoryImpl: DataRepository {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    // MARK: - DataRepository
    func rowCount(inTables tables: [String], database: Database) async -> [String: Int] {
        return await storage.count(tables: tables, on: database)
    }
}
