//
//  DeviceConnectButtonView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/18.
//

import SwiftUI
import CoreBluetooth

struct DeviceConnectButtonView: View {
    @EnvironmentObject var manager: DeviceManager
    var label: String
    var peripheral: CBPeripheral
    var type: ConnectType
    
    var body: some View {
        Button {
            switch type {
                case .connect: manager.connect(peripheral: peripheral)
                case .disConnect: manager.disConnect(peripheral: peripheral)
            }
        } label: {
            Text(label)
        }
        .padding()
    }
    
    enum ConnectType {
        case connect
        case disConnect
    }
}