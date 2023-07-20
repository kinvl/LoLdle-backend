import Vapor
import Fluent

func database(_ app: Application) throws {
    let configuration = try DatabaseConfiguration.configuration(forEnvironment: app.environment)
    app.databases.use(.postgres(configuration: configuration), as: .psql)
    
    var migrations: [Migration] {[
        CreateChampion(),
        CreateChallenge(),
        CreateStatistics(),
        CreatePlayer(),
        CreateToken()
    ]}
    
    migrations.forEach { migration in
        app.migrations.add(migration)
    }
    
    try app.autoMigrate().wait()
}
