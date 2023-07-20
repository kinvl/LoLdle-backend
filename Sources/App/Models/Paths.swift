//
//  Paths.swift
//  
//
//  Created by Krzysztof Kinal on 31/08/2022.
//

import Vapor

struct Path {
    static let challenge: PathComponent = "challenge"
    static let answer: PathComponent = "answer"
    static let champion: PathComponent = "champion"
    
    static let data: PathComponent = "data"
    static let championsData: PathComponent = "champions"
    static let dataCount: PathComponent = "count"
    
    static let statistics: PathComponent = "statistics"
}
