//
//  CronExpressionTests.swift
//  
//
//  Created by Krzysztof Kinal on 22/08/2022.
//

@testable import App
import XCTVapor
import XCTest

final class CronExpressionTests: XCTestCase {
    func testCreatingCronExpression() {
        // Given:
        let hour = 16
        let minute = 15
        let expected = "15 15 * * *"
        
        // When:
        let expression = CronExpression.expressionFor(hour: hour, minute: minute)
        
        // Then:
        XCTAssertEqual(expression, expected)
    }
    
    func testCreatingInvalidCronExpression() {
        // Given:
        let hour = 99
        let minute = 88
        let expected = "* * * * *"
        
        // When:
        let expression = CronExpression.expressionFor(hour: hour, minute: minute)
        
        // Then:
        XCTAssertEqual(expression, expected)
    }
    
    func testCreatingCronExpressionFor1AM() {
        // Given:
        let hour = 01
        let minute = 00
        let expected = "0 0 * * *"
        
        // When:
        let expression = CronExpression.expressionFor(hour: hour, minute: minute)
        
        // Then:
        XCTAssertEqual(expression, expected)
    }
    
    func testCreatingCronExpressionForMidnight() {
        // Given:
        let hour = 00
        let minute = 00
        let expected = "0 23 * * *"
        
        // When:
        let expression = CronExpression.expressionFor(hour: hour, minute: minute)
        
        // Then:
        XCTAssertEqual(expression, expected)
    }
}
