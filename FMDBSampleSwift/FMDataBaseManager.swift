//
//  FMDataBaseManager.swift
//  DataBaseFMDB
//
//  Created by iragam reddy, sreekanth reddy on 4/11/20.
//  Copyright © 2020 iragam reddy, sreekanth reddy. All rights reserved.
//

import Foundation
import FMDB

protocol FMDBCRUDOperationable {
    associatedtype DataModel
    var databse: FMDatabase! { get set }
    func inset(row: DataModel)
    func create()
    func read() -> [DataModel]
    func delete(rows:[DataModel])
}

final class FMDBManager {
    let dbName = "analyticsDB.sqllite"
    let pathToDB: String?
    static let shared = FMDBManager()
    let database: FMDatabase
    
    private init() {
        pathToDB = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/\(dbName)"
        database = FMDatabase(path: pathToDB)
        initilize()
    }
    
    deinit {
        print("when FMDBManager becomes nil")
        database.close()
    }
    
    private func initilize() {
        print("Initialized DB at Path ##### \(self.pathToDB)")
        if database != nil {
            database.open()
            print("db object created successfully \(database)")
        }
    }
    
}

class AnalyticsData: FMDBCRUDOperationable {
    var databse: FMDatabase! = FMDBManager.shared.database
    
    // Create Analytics Events table
    private static let Create = "" +
    "CREATE TABLE IF NOT EXISTS AnalyticsData (" +
      "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
      "eventname TEXT, " +
      "attributes TEXT, " +
      "timestamp INTEGER" +
    ");"

    // Select events
    private static let Select = "select * from AnalyticsData"

    // Inssert row in to Analytics Table.
    private static let Insert = "" +
    "INSERT INTO " +
      "AnalyticsData (eventname, attributes, timestamp) " +
    "VALUES " +
      "(?, ?, ?);"
    
    init() {
        create()
    }
    
    func inset(row: EventsData) {
        databse?.open()
        print("databse.. \(databse)")
        do {
            try FMDBManager.shared.database.executeUpdate(AnalyticsData.Insert, values: [row.eventname, row.attributes, row.timestamp])
        } catch let error {
            print("error is \(error)")
        }
       databse?.close()
    }
    
    func create() {
        databse?.open()
             do {
                 try FMDBManager.shared.database.executeUpdate(AnalyticsData.Create, values: nil)
             } catch let error {
                 print("error is \(error)")
             }
             databse?.close()
    }
    
    func read() ->  [EventsData] {
        var selectedData = [EventsData]()
        databse?.open()
        print("databse.. \(databse)!")
        do {
            if let results = try FMDBManager.shared.database.executeQuery(AnalyticsData.Select, withArgumentsIn: []) {
                while results.next() {
                    let event = EventsData(eventname: results.string(forColumnIndex: 1) ?? "", attributes: results.string(forColumnIndex: 2) ?? "", timestamp: results.date(forColumnIndex: 3) ?? Date())
                    selectedData.append(event)
                    
                }
            }
        } catch let error {
            print("error is \(error)")
        }
       databse?.close()
        return selectedData
    }
    
    func delete(rows:[EventsData]) {
        
    }
}
