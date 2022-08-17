//
//  SQLStatement.swift
//  
//
//  Created by Krzysztof Kinal on 10/09/2022.
//

struct SQLStatement {
    static func rowCount(inTables tables: [String]) -> String {
        return String(tables
            .reduce("SELECT") { partialResult, table in
                return partialResult + "(SELECT COUNT(*) FROM \(table)) AS \(table),"
            }
            .dropLast())
    }
}
