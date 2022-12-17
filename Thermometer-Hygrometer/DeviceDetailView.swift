//
//  DeviceDetailView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import SwiftUI
import CoreBluetooth

struct DeviceDetailView: View {
    @EnvironmentObject var manager: DeviceManager
    var device: Device
    var body: some View {
        VStack(alignment: .leading) {
            Text(device.peripheral.name ?? "unname device")
                .font(.title)
                .fontWeight(.bold)
            Text(manager.recievedData.description)
        }
    }
}
