//
//  ChallengeControllerTests.swift
//  
//
//  Created by Krzysztof Kinal on 07/09/2022.
//

@testable import App
import XCTVapor
import XCTest

final class ChallengeControllerTests: XCTestCase {
    func testGetChallengeChampion() throws {
        // Given:
        let expectedChallenge = Challenge.Public(challengeType: ChallengeType.champion.rawValue, challengeSecret: "Yuumi")
        let app = Application(.testing)
        defer { app.shutdown() }
        try MainApplication().configure(app)
        try? DatabaseHelper.setupDefaultTestTables(inDatabase: app.db)
        
        // When:
        try app.test(.GET, "/\(Path.challenge)/\(Path.champion)", afterResponse: { res in
            let decodedResponse = try res.content.decode(Challenge.Public.self)
            
            // Then:
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.headers.contentType, .json)
            XCTAssertEqual(decodedResponse, expectedChallenge)
            
            try DatabaseHelper.deleteRowsFromTables(inDatabase: app.db)
        })
    }
    
    func testPostChallengeChampion() throws {
        // Given:
        let expectedStatistic = Statistic.Public(challengeType: ChallengeType.champion.rawValue, completions: 1) // On POST request, completions should get incremented by 1
        let app = Application(.testing)
        defer { app.shutdown() }
        try MainApplication().configure(app)
        try? DatabaseHelper.setupDefaultTestTables(inDatabase: app.db)
        
        // When:
        try app.test(.POST, "/\(Path.challenge)/\(Path.champion)/\(Path.answer)", afterResponse: { res in
            let decodedResponse = try res.content.decode(Statistic.Public.self)
            
            // Then:
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.headers.contentType, .json)
            XCTAssertEqual(decodedResponse, expectedStatistic)
            
            try DatabaseHelper.deleteRowsFromTables(inDatabase: app.db)
        })
    }
}
