//
//  ChallengeType.swift
//  
//
//  Created by Krzysztof Kinal on 19/08/2022.
//

import Foundation

enum ChallengeType: String {
    case champion
    case quote
    case ability
    case splash
    
    var id: Int {
        switch self {
        case .champion:
            return 0
        case .quote:
            return 1
        case .ability:
            return 2
        case .splash:
            return 3
        }
    }
}
