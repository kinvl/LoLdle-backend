//
//  DatabaseConfiguration.swift
//  
//
//  Created by Krzysztof Kinal on 05/09/2022.
//

import Vapor
import FluentPostgresDriver

struct DatabaseConfiguration {
    static func configuration(forEnvironment environment: Environment) throws -> PostgresConfiguration {
        var configuration: PostgresConfiguration
        
        switch environment {
        case .development, .testing:
            let hostname = Environment.get("DATABASE_HOST") ?? "localhost"
            let port = 5432
            let username = Environment.get("DATABASE_USERNAME") ?? "vapor_username"
            let password = Environment.get("DATABASE_PASSWORD") ?? "vapor_password"
            let database = Environment.get("DATABASE_NAME") ?? "vapor_database"
            configuration = PostgresConfiguration(hostname: hostname, port: port, username: username, password: password, database: database, tlsConfiguration: nil)
        case .production:
            guard let databaseURL = Environment.get("DATABASE_URL"), let configurationFromURL = PostgresConfiguration(url: databaseURL) else { throw Abort(.serviceUnavailable) }
            configuration = configurationFromURL
            configuration.tlsConfiguration = .makeClientConfiguration()
            configuration.tlsConfiguration?.certificateVerification = .none
        default:
            throw Abort(.serviceUnavailable)
        }
        
        return configuration
    }
}
