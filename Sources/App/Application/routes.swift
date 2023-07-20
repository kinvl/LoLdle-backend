import Vapor

func routes(_ app: Application) throws {
    app.routes.caseInsensitive = true
    
    var routesCollections: [RouteCollection] {[
        app.resolver.resolve(ChallengeController.self)!,
        app.resolver.resolve(DataController.self)!,
        app.resolver.resolve(StatisticsController.self)!
    ]}
    
    try routesCollections.forEach { collection in
        try app.register(collection: collection)
    }
}
