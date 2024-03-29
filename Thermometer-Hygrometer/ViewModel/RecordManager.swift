//
//  RecordManager.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/09.
//

import Foundation
import RealmSwift

class RecordManager: ObservableObject {
    @Published var records:[Record] = [Record]()
    private let service = RecordService()
    
    init(){
        service.fetch { records in
            self.records = Array(records)
        }
    }
    
    func getRecords(completion: @escaping ([Record]) -> Void) {
        service.fetch { records in
            completion(Array(records))
        }
    }
    
    func add(_ record: Record) {
        service.add(record) { record in
            self.records.append(record)
        }
        self.records.sort { $0.date > $1.date }
    }
    
    func deleteAll() {
        self.records = []
    }
}

