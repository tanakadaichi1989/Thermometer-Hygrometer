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
    @Environment(\.managedObjectContext) var viewContext
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
                .font(.title3)
                .fontWeight(.bold)
                .padding(5)
                .frame(width: 120, height: 120)
                .foregroundColor(.primary)
                .overlay(
                    Circle()
                        .stroke(Color.primary, lineWidth: 1)
                )
        }
        .padding()

    }
    
    enum ConnectType {
        case connect
        case disConnect
    }
}
