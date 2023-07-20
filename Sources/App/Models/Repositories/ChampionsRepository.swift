//
//  ChampionsRepository.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Vapor
import Fluent

protocol ChampionsRepository {
    func getAllChampions(database: Database) async -> [Champion]?
    func getAllChampionNames(database: Database) async -> [String]?
}

class ChampionsRepositoryImpl: ChampionsRepository {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    // MARK: - ChampionsRepository
    func getAllChampions(database: Database) async -> [Champion]? {
        return await storage.all(Champion.self, on: database)
    }
    
    func getAllChampionNames(database: Database) async -> [String]? {
        let column = FieldKey.name.description
        let table = Champion.schema
        
        return await storage.column(column, table: table, type: String.self, on: database)
    }
}
