//
//  DatabaseStorage.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Foundation
import FluentKit
import SQLKit

protocol Storage {
    func find<Element: Model>(_ object: Element.Type, id: Element.IDValue, on database: Database) async -> Element?
    func all<Element: Model>(_ object: Element.Type, on database: Database) async -> [Element]?
    func column<Element: Decodable>(_ column: String, table: String, type: Element.Type, on database: Database) async -> [Element]?
    func count(tables: [String], on database: Database) async -> [String: Int]
}

class DatabaseStorage: Storage {
    func find<Element: Model>(_ object: Element.Type, id: Element.IDValue, on database: Database) async -> Element? {
        return try? await object.find(id, on: database)
    }
    
    func all<Element: Model>(_ object: Element.Type, on database: Database) async -> [Element]? {
        return try? await object.query(on: database).all()
    }
    
    func column<Element: Decodable>(_ column: String, table: String, type: Element.Type, on database: Database) async -> [Element]? {
        return try? await (database as? SQLDatabase)?
            .select()
            .column(column)
            .from(table)
            .all()
            .compactMap({ row in
                return try? row.decode(column: column, as: type)
            })
    }
    
    func count(tables: [String], on database: Database) async -> [String: Int] {
        let statement = SQLStatement.rowCount(inTables: tables)
        let queryString = SQLQueryString(statement)
        let row = try? await (database as? SQLDatabase)?
            .raw(queryString)
            .first()
        
        return tables.reduce(into: [:]) { partialResult, table in
            return partialResult[table] = try? row?.decode(column: table, as: Int.self)
        }
    }
}
