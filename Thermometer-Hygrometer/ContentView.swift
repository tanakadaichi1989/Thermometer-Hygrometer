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
                    HStack {
                        DeviceConnectButtonView(label: "Connect", peripheral: manager.devices[0].peripheral, type: .connect)
                        DeviceConnectButtonView(label: "DisConnect", peripheral: manager.devices[0].peripheral, type: .disConnect)
                    }
                    Text(manager.devices[0].peripheral.name ?? "unnamed device")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .padding()

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
