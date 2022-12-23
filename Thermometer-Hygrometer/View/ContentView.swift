//
//  ContentView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: DeviceManager
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var records: FetchedResults<Record>
    
    var body: some View {
        VStack {
            if manager.devices.count == 0 {
                UnconnectView()
            } else {
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
                        DeviceConnectButtonView(label: "Connect", peripheral: manager.devices[0].peripheral, type: .connect)
                        DeviceConnectButtonView(label: "Disconnect", peripheral: manager.devices[0].peripheral, type: .disConnect)
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
}

extension ContentView {
    /*
    private func save(){
        let record = Record(context: viewContext)
        guard let temperatureCelsius = Double.convert(manager.recievedData[4],manager.recievedData[5]) else { return }
        record.id = UUID()
        record.date = Date()
        record.deviceName = manager.devices[0].peripheral.name ?? "unnamed device"
        record.temperatureCelsius = temperatureCelsius
        record.humidityPercent = Double(manager.recievedData[6])
        record.batteryLevel = Double(manager.batteryLevelData[2] * 10)
    }
     */
}
