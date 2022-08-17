//
//  DataController.swift
//  
//
//  Created by Krzysztof Kinal on 31/08/2022.
//

import Vapor

final class DataController: RouteCollection {
    private let championsRepository: ChampionsRepository
    private let dataRepository: DataRepository
    
    // MARK: - Initialization
    init(championsRepository: ChampionsRepository, dataRepository: DataRepository) {
        self.championsRepository = championsRepository
        self.dataRepository = dataRepository
    }
    
    // MARK: - RouteCollection
    func boot(routes: RoutesBuilder) throws {
        routes.group(Path.data) { data in
            data.get(Path.championsData, use: getChampionsData)
            data.get(Path.dataCount, use: getDataCount)
        }
    }
    
    // MARK: - Private
    private func getChampionsData(req: Request) async throws -> Champion.PublicData {
        guard let champions = await championsRepository.getAllChampions(database: req.db) else { throw Abort(.notFound) }
        let championsData = Champion.PublicData(champions: champions)
        
        return championsData
    }
    
    private func getDataCount(req: Request) async throws -> [String: Int] {
        return await dataRepository.rowCount(inTables: [Champion.schema], database: req.db)
    }
}

