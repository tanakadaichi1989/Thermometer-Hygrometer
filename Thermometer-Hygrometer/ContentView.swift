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
                    Text(self.format(Date()))
                        .font(.title3)
                        .fontWeight(.bold)
                    VStack {
                        if manager.recievedData.count != 0 {
                            MeasurementDataView(data: self.convert(manager.recievedData[4],manager.recievedData[5]), type: .thermometer)
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
    private func convert(_ data1: Int, _ data2: Int) -> Double? {
        switch data1 + data2 {
            case 0: return 0.0
            case 0...500: return (Double(data1) + Double(data2)) / 10
            case 65436...65535: return (Double(data1) + Double(data2) - 65536.0) / 10
            default: return nil
        }
    }
    
    private func format(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return df.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
