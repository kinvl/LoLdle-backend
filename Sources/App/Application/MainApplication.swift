//
//  MainApplication.swift
//  
//
//  Created by Krzysztof Kinal on 03/09/2022.
//

import Vapor
import NIOCronScheduler

/** `MainApplication` is an entry point for the application. */
public final class MainApplication {
    /** The actual application object.*/
    static private(set) var app: Application!
    
    /** All scheduled cron jobs.*/
    static private(set) var cronJobs: [NIOCronJob] = []
    
    // MARK: - Initialization
    public init() {}
    
    /** Initial configuration method. This must be called before running the application. */
    public func configure(_ app: Application) throws {
        MainApplication.app = app
        
        try database(app)
        try cron(app)
        try routes(app)
    }
    
    // MARK: - Private
    // MARK: Configuration
    private func routes(_ app: Application) throws {
        app.routes.caseInsensitive = true
        
        // Routes collections (controllers) used in app. Any controller to be registered should go here.
        var routesCollections: [RouteCollection] {[
            Assembler.assembler.resolver.resolve(ChallengeController.self)!,
            Assembler.assembler.resolver.resolve(DataController.self)!,
            Assembler.assembler.resolver.resolve(StatisticsController.self)!
        ]}
        
        try routesCollections.forEach { collection in
            try app.register(collection: collection)
        }
    }
    
    private func database(_ app: Application) throws {
        let configuration = try DatabaseConfiguration.configuration(forEnvironment: app.environment)
        app.databases.use(.postgres(configuration: configuration), as: .psql)
        
        // Add database migrations here.
        do {
            app.migrations.add(CreateChampion())
            app.migrations.add(CreateChallenge())
            app.migrations.add(CreateStatistics())
        }
        
        try app.autoMigrate().wait()
    }
    
    private func cron(_ app: Application) throws {
        // FIXME: Find a way to use Dataset without resolving it first
        // Resolve Dataset so it gets created before first access in cronjob or else `champions` set will be empty.
        _ = Assembler.assembler.resolver.resolve(Dataset.self)!
        
        // Add and schedule cron jobs only from here so they are available in static `cronJobs` array.
        var jobs: [NIOCronJob] {[
            try! app.cron.schedule(CronJob.RefreshDailyChallenges.self),
            try! app.cron.schedule(CronJob.ResetDailyStatistics.self)
        ]}
        
        jobs.forEach { cronJob in
            MainApplication.cronJobs.append(cronJob)
        }
    }
}
