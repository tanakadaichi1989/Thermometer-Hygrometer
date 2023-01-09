//
//  ContentView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import SwiftUI
import Foundation
import CoreData

struct MainView: View {
    @EnvironmentObject var manager: DeviceManager
    @EnvironmentObject var timerManager: TimerManager
    @State var isSave: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text(String.format(Date()))
                    .font(.title3)
                    .fontWeight(.bold)
                VStack {
                    if manager.recievedData.count != 0 {
                        MeasurementDataView(data: Double.convert(manager.recievedData[4],manager.recievedData[5]), type: .thermometer)
                        MeasurementDataView(data: Double(manager.recievedData[6]), type: .hygrometer)
                    } else {
                        MeasurementDataView(data: nil, type: .thermometer)
                        MeasurementDataView(data: nil, type: .hygrometer)
                    }
                }
                .padding()
                
                HStack {
                    Text("Save measurement data")
                    Toggle("", isOn: $isSave)
                        .labelsHidden()
                }
                .padding()
                
                HStack {
                    DeviceConnectButtonView(label: "Connect", peripheral: manager.devices[0].peripheral, type: .connect){
                        timerManager.startTimer(withTimeInterval: 10){
                            // if isSave { saveData() }
                        }
                    }
                    DeviceConnectButtonView(label: "Disconnect", peripheral: manager.devices[0].peripheral, type: .disConnect){
                        timerManager.endTimer() {
                            isSave = false
                        }
                    }
                }
                Text(manager.devices[0].peripheral.name ?? "unnamed device")
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .padding(1)
                if manager.batteryLevelData.count > 0 {
                    DeviceBatteryView(batteryLevel: manager.batteryLevelData[2])
                }
            }
        }
    }
}
