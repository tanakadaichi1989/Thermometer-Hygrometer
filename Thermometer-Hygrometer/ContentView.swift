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
            } else {
                VStack {
                    Text(Date().description)
                        .font(.subheadline)
                        .fontWeight(.thin)
                    HStack {
                        HStack {
                            Image(systemName: "thermometer.medium")
                                .font(.largeTitle)
                            if manager.recievedData.count == 0 {
                                Text("-")
                                    .font(.largeTitle)
                            } else {
                                Text("\(self.convert(manager.recievedData[4])) ℃")
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                        HStack {
                            Image(systemName: "humidity.fill")
                                .font(.largeTitle)
                            if manager.recievedData.count == 0 {
                                Text("-")
                                    .font(.largeTitle)
                            } else {
                                Text("\(manager.recievedData[6].description) %")
                                    .font(.largeTitle)
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
    
    private func convert(_ data: Int) -> String {
        var doubleData = Double(data) / 10
        return String(format: "%.1f", doubleData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
