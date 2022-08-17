//
//  SQLStatementTests.swift
//  
//
//  Created by Krzysztof Kinal on 10/09/2022.
//

@testable import App
import XCTVapor
import XCTest

final class SQLStatementTests: XCTestCase {
    func testRowCountStatement() {
        // Given:
        let tables = ["test", "test2", "test3"]
        let expected = "SELECT(SELECT COUNT(*) FROM test) AS test,(SELECT COUNT(*) FROM test2) AS test2,(SELECT COUNT(*) FROM test3) AS test3"
        
        // When:
        let statement = SQLStatement.rowCount(inTables: tables)
        
        // Then:
        XCTAssertEqual(statement, expected)
    }
}

