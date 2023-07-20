import Vapor
import Fluent
import VaporCron

public func bootstrap(_ app: Application) throws {
    try database(app)
    try cron(app)
    try routes(app)
}
