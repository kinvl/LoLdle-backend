//
//  DatabaseModels+Equatable.swift
//  
//
//  Created by Krzysztof Kinal on 07/09/2022.
//

@testable import App

extension Champion: Equatable {
    public static func == (lhs: Champion, rhs: Champion) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.gender == rhs.gender &&
        lhs.position == rhs.position &&
        lhs.species == rhs.species &&
        lhs.resource == rhs.resource &&
        lhs.rangeType == rhs.rangeType &&
        lhs.region == rhs.region &&
        lhs.releaseYear == rhs.releaseYear
    }
}

extension Challenge.Public: Equatable {
    public static func == (lhs: Challenge.Public, rhs: Challenge.Public) -> Bool {
        return lhs.challengeType == rhs.challengeType &&
        lhs.challengeSecret == rhs.challengeSecret
    }
}

extension Statistic.Public: Equatable {
    public static func == (lhs: Statistic.Public, rhs: Statistic.Public) -> Bool {
        return lhs.challengeType == rhs.challengeType &&
        lhs.completions == rhs.completions
    }
}
