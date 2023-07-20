//
//  Challenge.swift
//  
//
//  Created by Krzysztof Kinal on 19/08/2022.
//

import Vapor
import FluentKit

final class Challenge: Model {
    static let schema = "challenges"
    typealias IDValue = Int
    
    @ID(custom: .id)
    var id: Int?
    
    @Field(key: .challengeType)
    var challengeType: String
    
    @Field(key: .challengeSecret)
    var challengeSecret: String
    
    init() {}
    
    init(id: Int? = nil, challengeType: String, challengeSecret: String) {
        self.id = id
        self.challengeType = challengeType
        self.challengeSecret = challengeSecret
    }
    
    final class Public {
        var challengeType: String
        var challengeSecret: String
        
        init(challengeType: String, challengeSecret: String) {
            self.challengeType = challengeType
            self.challengeSecret = challengeSecret
        }
    }
}

extension Challenge: Content {
    func mapToPublic() -> Challenge.Public {
        return Challenge.Public(challengeType: self.challengeType, challengeSecret: self.challengeSecret)
    }
}

extension Challenge.Public: Content {}

extension FieldKey {
    static var challengeType: Self { "challenge_type" }
    static var challengeSecret: Self { "challenge_secret" }
}
