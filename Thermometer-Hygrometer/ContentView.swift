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
        NavigationView {
            List(manager.devices, id: \.self){ device in
                NavigationLink {
                    DeviceDetailView(device: device)
                } label: {
                    Text(device.peripheral.name ?? "unnamed device")
                        .fontWeight(.bold)
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
