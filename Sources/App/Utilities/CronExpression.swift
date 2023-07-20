//
//  CronExpression.swift
//  
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

struct CronExpression {
    static func expressionFor(hour: Int, minute: Int) -> String {
        guard 0...23 ~= hour, 0...59 ~= minute else { return "* * * * *" }
        
        var offsettedHour: Int = 0
        switch hour {
        case 1:
            break
        case 0:
            offsettedHour = 23
        default:
            offsettedHour = hour - 1
        }

        return "\(minute) \(offsettedHour) * * *"
    }
}
