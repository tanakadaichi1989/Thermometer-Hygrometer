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
    @EnvironmentObject var recordManager: RecordManager
    @EnvironmentObject var settingManager: SettingManager
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
                        .disabled(!manager.isConnected)
                }
                .padding()
                
                HStack {
                    DeviceConnectButtonView(label: "Connect", peripheral: manager.devices[0].peripheral, type: .connect,disabled: manager.isConnected){
                        timerManager.startTimer(withTimeInterval: 10){
                            if isSave { saveRecord() }
                        }
                    }
                    DeviceConnectButtonView(label: "Disconnect", peripheral: manager.devices[0].peripheral, type: .disConnect,disabled: !manager.isConnected){
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

extension MainView {
    private func saveRecord(){
        guard let deviceName = manager.devices[0].peripheral.name else { return }
        guard let temperatureCelsius = Double.convert(manager.recievedData[4],manager.recievedData[5]) else { return }
        let record = Record(date: Date(), deviceName: deviceName, temperatureCelsius: temperatureCelsius, humidityPercent: Double(manager.recievedData[6]), batteryLevel: Double(manager.batteryLevelData[2]))
        recordManager.add(record)
    }
}
