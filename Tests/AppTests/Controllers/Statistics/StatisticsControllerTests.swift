//
//  StatisticsControllerTests.swift
//  
//
//  Created by Krzysztof Kinal on 22/08/2022.
//

@testable import App
import XCTVapor
import XCTest

final class StatisticsControllerTests: XCTestCase {
    func testGetStatistics() throws {
        // Given:
        let expectedStatistics = [Statistic.Public(challengeType: ChallengeType.champion.rawValue, completions: 0),
                                  Statistic.Public(challengeType: ChallengeType.quote.rawValue, completions: 1),
                                  Statistic.Public(challengeType: ChallengeType.ability.rawValue, completions: 2),
                                  Statistic.Public(challengeType: ChallengeType.splash.rawValue, completions: 3)]
        let app = Application(.testing)
        defer { app.shutdown() }
        try bootstrap(app)
        try? DatabaseHelper.setupDefaultTestTables(inDatabase: app.db)
        
        // When:
        try app.test(.GET, "/\(Path.statistics)/", afterResponse: { res in
            let decodedResponse = try res.content.decode([Statistic.Public].self)
            
            // Then:
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.headers.contentType, .json)
            XCTAssertEqual(decodedResponse.count, expectedStatistics.count)
            zip(decodedResponse, expectedStatistics).forEach { (statistic, expectedStatistic) in
                XCTAssertEqual(statistic, expectedStatistic)
            }
            
            try DatabaseHelper.deleteRowsFromTables(inDatabase: app.db)
        })
    }
}
