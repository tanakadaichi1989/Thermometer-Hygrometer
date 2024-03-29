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
    @Environment(\.managedObjectContext) var recordViewContext
    
    var label: LocalizedStringKey
    var peripheral: CBPeripheral
    var type: ConnectType
    var disabled: Bool
    var completion: () -> Void

    var body: some View {
        Button {
            switch type {
                case .connect:
                    manager.connect(peripheral: peripheral)
                case .disConnect:
                    manager.disConnect(peripheral: peripheral)
            }
            completion()
        } label: {
            CircleButton(label: label)
        }
        .disabled(disabled)
        .padding()

    }
    
    enum ConnectType {
        case connect
        case disConnect
    }
}
