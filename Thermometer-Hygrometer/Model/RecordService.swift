//
//  RecordService.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/09.
//

import Foundation
import RealmSwift

class RecordService {
    private static var config = Realm.Configuration(schemaVersion: 1)
    private static var realm = try! Realm(configuration: config)
    
    func fetch(completion: (Results<Record>) -> Void) {
            let result = RecordService.realm.objects(Record.self)
            completion(result)
        }
        
    func add(_ record: Record, completion: @escaping (Record) -> Void) {
        try! RecordService.realm.write {
            RecordService.realm.add(record)
            completion(record)
        }
    }
        
    func deleteAll(completion: ([Record]) -> Void) {
        try! RecordService.realm.write {
            RecordService.realm.deleteAll()
        }
        self.fetch { records in
                completion(Array(records))
        }
    }
}
