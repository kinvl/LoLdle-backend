//
//  Dataset.swift
//  
//
//  Created by Krzysztof Kinal on 22/08/2022.
//

final class Dataset {
    var champions: Set<String> = []
    
    // MARK: - Init
    init(championsRepository: ChampionsRepository) {
        Task {
            champions = await (championsRepository.getAllChampionNames(database: MainApplication.app.db) ?? [])
                .reduce(into: Set<String>(), { partialSet, object in
                    partialSet.insert(object)
                })
        }
    }
}
