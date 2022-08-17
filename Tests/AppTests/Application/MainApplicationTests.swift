//
//  MainApplicationTests.swift
//  
//
//  Created by Krzysztof Kinal on 04/09/2022.
//

@testable import App
import XCTVapor

final class MainApplicationTests: XCTestCase {
    func testIfAppObjectIsSet() throws {
        // Given:
        let app = Application(.testing)
        defer { app.shutdown() }

        // When:
        try MainApplication().configure(app)
        
        // Then:
        XCTAssertNotNil(MainApplication.app)
    }
    
    func testIfDatabaseIsConfigured() throws {
        // Given:
        let app = Application(.testing)
        defer { app.shutdown() }

        // When:
        try MainApplication().configure(app)
        
        // Then:
        _ = app.db // Accessing unconfigured database results in a fatal error
        XCTAssert(true)
    }
    
    func testIfRoutesAreRegistered() throws {
        // Given:
        let app = Application(.testing)
        defer { app.shutdown() }

        // When:
        try MainApplication().configure(app)
        
        // Then:
        XCTAssert(!app.routes.all.isEmpty)
    }
    
    func testIfCronJobsAreScheduled() throws {
        // Given:
        let app = Application(.testing)
        defer { app.shutdown() }

        // When:
        try MainApplication().configure(app)
        
        // Then:
        XCTAssert(!MainApplication.cronJobs.isEmpty)
    }
}
