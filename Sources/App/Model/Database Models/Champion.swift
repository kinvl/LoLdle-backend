//
//  Champion.swift
//  
//
//  Created by Krzysztof Kinal on 31/08/2022.
//

import Vapor
import FluentKit

final class Champion: Model {
    static let schema = "champions"
    typealias IDValue = Int
    
    @ID(custom: .id)
    var id: Int?
    
    @Field(key: .name)
    var name: String
    
    @Field(key: .gender)
    var gender: String
    
    @Field(key: .position)
    var position: [String]
    
    @Field(key: .species)
    var species: [String]
    
    @Field(key: .resource)
    var resource: String
    
    @Field(key: .rangeType)
    var rangeType: String
    
    @Field(key: .region)
    var region: [String]
    
    @Field(key: .releaseYear)
    var releaseYear: Int
    
    init() {}
    
    init(id: Int? = nil, name: String, gender: String,
         position: [String], species: [String], resource: String,
         rangeType: String, region: [String], releaseYear: Int) {
        self.id = id
        self.name = name
        self.gender = gender
        self.position = position
        self.species = species
        self.resource = resource
        self.rangeType = rangeType
        self.region = region
        self.releaseYear = releaseYear
    }
    
    final class PublicData: Codable {
        var iconURL = "https://cdn.communitydragon.org/12.13.1/champion/@id/square"
        var champions: [Champion]
        
        init(champions: [Champion]) {
            self.champions = champions
        }
    }
}

extension Champion: Content {}

extension Champion.PublicData: Content {}

extension FieldKey {
    static var name: Self { "name" }
    static var gender: Self { "gender" }
    static var position: Self { "position" }
    static var species: Self { "species" }
    static var resource: Self { "resource" }
    static var rangeType: Self { "range_type" }
    static var region: Self { "region" }
    static var releaseYear: Self { "release_year" }
    static var icon: Self { "icon" }
}
