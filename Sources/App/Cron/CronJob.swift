//
//  CronJob.swift
//  
//
//  Created by Krzysztof Kinal on 05/09/2022.
//

import Vapor
import VaporCron

struct CronJob {
    static let dailyExpression = CronExpression.expressionFor(hour: 22, minute: 0)
}
