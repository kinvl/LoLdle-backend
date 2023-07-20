import Vapor

func cron(_ app: Application) throws {
    try app.cron.schedule(CronJob.RefreshDailyChallenges.self)
    try app.cron.schedule(CronJob.ResetDailyStatistics.self)
}
