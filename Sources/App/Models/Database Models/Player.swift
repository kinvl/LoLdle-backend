//
//  Player.swift
//  
//
//  Created by Krzysztof Kinal on 19/07/2023.
//

import Fluent

final class Player: Model {
    static let schema = "players"
    
    @ID
    var id: UUID?
}
