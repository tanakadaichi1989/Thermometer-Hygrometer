//
//  ContentView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: DeviceManager
    
    var body: some View {
        
        VStack {
            if manager.devices.count == 0 {
                Text("センサの電源を入れ、温度計・湿度計デバイスのボタンをタップすると、アプリと接続できます")
                    .padding()
            } else {
                VStack {
                    Text(self.format(Date()))
                        .font(.title3)
                        .fontWeight(.bold)
                    VStack {
                        HStack {
                            Image(systemName: "thermometer.medium")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            if manager.recievedData.count == 0 {
                                Text("-")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            } else {
                                Text("\(self.convert(manager.recievedData[4],manager.recievedData[5])) ℃")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding()
                        HStack {
                            Image(systemName: "humidity.fill")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            if manager.recievedData.count == 0 {
                                Text("-")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            } else {
                                Text("\(manager.recievedData[6].description) %")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding()
                    }
                    .padding()
                    HStack {
                        DeviceConnectButtonView(label: "Connect", peripheral: manager.devices[0].peripheral, type: .connect)
                        DeviceConnectButtonView(label: "Disconnect", peripheral: manager.devices[0].peripheral, type: .disConnect)
                    }
                    Text(manager.devices[0].peripheral.name ?? "unnamed device")
                        .font(.subheadline)
                        .fontWeight(.thin)
                    if manager.batteryLevelData.count > 0 {
                        Text("\(manager.batteryLevelData[2] * 10) %")
                            .font(.subheadline)
                            .fontWeight(.thin)
                    }
                }
            }
        }
    }
}

extension ContentView {
    private func convert(_ data1: Int, _ data2: Int) -> String {
        var doubleData1 = Double(data1)
        var doubleData2 = Double(data2 * 256)
        var result = (doubleData1 == 0.0 && doubleData2 == 0) ? 0.0 : (doubleData1 + doubleData2)/10
        return String(format: "%.1f", result)
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
