//
//  Dataset.swift
//  
//
//  Created by Krzysztof Kinal on 22/08/2022.
//
import Fluent

final class Dataset {
    private let database: Database
    private let championsRepository: ChampionsRepository
    
    func drawChampion() async -> String? {
        await championsRepository.getAllChampionNames(database: database)?.randomElement()
    }
    
    // MARK: - Init
    init(database: Database, championsRepository: ChampionsRepository)  {
        self.database = database
        self.championsRepository = championsRepository
    }
}
