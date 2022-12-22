//
//  Thermometer_HygrometerApp.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import SwiftUI
import CoreBluetooth

@main
struct Thermometer_HygrometerApp: App {
    @StateObject var manager: DeviceManager = DeviceManager()
    let recordManager: RecordManager = RecordManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, recordManager.container.viewContext)
        }
    }
}
