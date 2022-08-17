//
//  Statistic.swift
//  
//
//  Created by Krzysztof Kinal on 19/08/2022.
//

import Vapor
import FluentKit

final class Statistic: Model {
    static let schema = "statistics"
    typealias IDValue = Int
    
    @ID(custom: .id)
    var id: Int?
    
    @Field(key: .challengeType)
    var challengeType: String
    
    @Field(key: .completions)
    var completions: Int
    
    init() {}
    
    init(id: Int? = nil, challengeType: String, completions: Int) {
        self.id = id
        self.challengeType = challengeType
        self.completions = completions
    }
    
    final class Public {
        var challengeType: String
        var completions: Int
        
        init(challengeType: String, completions: Int) {
            self.challengeType = challengeType
            self.completions = completions
        }
    }
}

extension Statistic: Content {
    func mapToPublic() -> Statistic.Public {
        return Statistic.Public(challengeType: self.challengeType, completions: self.completions)
    }
}

extension Statistic.Public: Content {}

extension FieldKey {
    static var completions: Self { "completions" }
}
