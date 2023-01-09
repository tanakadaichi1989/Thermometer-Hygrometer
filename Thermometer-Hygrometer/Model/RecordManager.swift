//
//  RecordManager.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/23.
//

import Foundation
import CoreData

class RecordManager: ObservableObject {
    let container: NSPersistentContainer = NSPersistentContainer(name: "Record")
    init(){
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
