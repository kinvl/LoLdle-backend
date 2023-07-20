//
//  DataControllerTests.swift
//  
//
//  Created by Krzysztof Kinal on 07/09/2022.
//

@testable import App
import XCTVapor
import XCTest

final class DataControllerTests: XCTestCase {
    func testGetDataChampions() throws {
        // Given:
        let expectedChampions = [Champion(id: 0, name: "Yuumi", gender: "female", position: ["support"], species: ["cat", "rat"], resource: "health", rangeType: "ranged", region: ["bandleCity"], releaseYear: 2020),
                                 Champion(id: 1, name: "Lulu", gender: "male", position: ["top", "bot"], species: ["unknown"], resource: "mana", rangeType: "melee", region: ["shadowIsles", "blessedIsles"], releaseYear: 2000)]
        let app = Application(.testing)
        defer { app.shutdown() }
        try bootstrap(app)
        try? DatabaseHelper.setupDefaultTestTables(inDatabase: app.db)
        
        // When:
        try app.test(.GET, "/\(Path.data)/\(Path.championsData)", afterResponse: { res in
            let decodedResponse = try res.content.decode(Champion.PublicData.self)
            
            // Then:
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.headers.contentType, .json)
            XCTAssertEqual(decodedResponse.iconURL, "https://cdn.communitydragon.org/12.13.1/champion/@id/square")
            zip(decodedResponse.champions, expectedChampions).forEach { (champion, expectedChampion) in
                XCTAssertEqual(champion, expectedChampion)
            }
            
            try DatabaseHelper.deleteRowsFromTables(inDatabase: app.db)
        })
    }
    
    func testGetDataCount() throws {
        // Given:
        let app = Application(.testing)
        defer { app.shutdown() }
        try bootstrap(app)
        try? DatabaseHelper.setupDefaultTestTables(inDatabase: app.db)
        
        // When:
        try app.test(.GET, "/\(Path.data)/\(Path.dataCount)", afterResponse: { res in
            let decodedResponse = try! res.content.decode([String: Int].self)
            
            // Then:
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.headers.contentType, .json)
            XCTAssertEqual(decodedResponse["champions"], 2)
            
            try DatabaseHelper.deleteRowsFromTables(inDatabase: app.db)
        })
    }
}
