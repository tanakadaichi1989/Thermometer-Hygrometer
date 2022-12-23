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
    var label: String
    var peripheral: CBPeripheral
    var type: ConnectType
    
    var body: some View {
        Button {
            switch type {
                case .connect:
                    manager.connect(peripheral: peripheral)
                    /*
                    Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
                    save()
                    }
                    */
                case .disConnect:
                    manager.disConnect(peripheral: peripheral)
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

extension DeviceConnectButtonView {
    private func save(){
        guard manager.hasDevice() else { return }
        let record = Record(context: recordViewContext)
        guard manager.recievedData.count != 0 else { return }
        guard let temperatureCelsius = Double.convert(manager.recievedData[4],manager.recievedData[5]) else { return }
        record.id = UUID()
        record.date = Date()
        record.deviceName = manager.devices[0].peripheral.name ?? "unnamed device"
        record.temperatureCelsius = temperatureCelsius
        record.humidityPercent = Double(manager.recievedData[6])
        record.batteryLevel = Double(manager.batteryLevelData[2] * 10)
        try! recordViewContext.save()
    }
}
