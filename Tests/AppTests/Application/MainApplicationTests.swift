//
//  MainApplicationTests.swift
//  
//
//  Created by Krzysztof Kinal on 04/09/2022.
//

@testable import App
import XCTVapor

final class MainApplicationTests: XCTestCase {
    func testIfDatabaseIsConfigured() throws {
        // Given:
        let app = Application(.testing)
        defer { app.shutdown() }

        // When:
        try bootstrap(app)
        
        // Then:
        _ = app.db // Accessing unconfigured database results in a fatal error
        XCTAssert(true)
    }
    
    func testIfRoutesAreRegistered() throws {
        // Given:
        let app = Application(.testing)
        defer { app.shutdown() }

        // When:
        try bootstrap(app)
        
        // Then:
        XCTAssert(!app.routes.all.isEmpty)
    }
}
