//
//  DeviceManager.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import Foundation
import CoreBluetooth
import SwiftUI

class DeviceManager: NSObject, ObservableObject {
    private let centralManager: CBCentralManager
    private let services:[CBUUID] = [CBUUID(string: MESH.UUID.description)]
    @Published var devices:[Device] = []
    @Published var recievedData:[Int] = []
    @Published var batteryLevelData:[Int] = []
    
    override init(){
        centralManager = CBCentralManager(delegate: nil, queue: nil)
        super.init()
        centralManager.delegate = self
        self.scan()
    }
    
    func scan(){
        centralManager.scanForPeripherals(withServices: services,options: nil)
    }
    
    func stopScan(){
        centralManager.stopScan()
    }
    
    func connect(peripheral: CBPeripheral){
        centralManager.connect(peripheral,options: nil)
    }
    
    func disConnect(peripheral: CBPeripheral){
        centralManager.cancelPeripheralConnection(peripheral)
    }
    
    func analyze(data: Data) -> [Int] {
        var result:[Int] = []
        data.map { i in result.append(Int(i)) }
        return result
    }
    
    func hasDevice() -> Bool {
        self.devices.count != 0
    }
}

extension DeviceManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: services)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let name = peripheral.name else { return }
        guard name.hasPrefix(MESH.TH.description) else  { return }
        let device = Device(peripheral: peripheral, rssi: RSSI)
        if let index = devices.firstIndex(where: { $0.peripheral.identifier == device.peripheral.identifier }) {
            devices[index] = device
        } else {
            devices.append(device)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        guard let peripheral = devices.first?.peripheral else { return }
        peripheral.delegate = self
        peripheral.discoverServices(services)
        print("centralManager did connect peripheral: \(peripheral.name?.description ?? "unnnamed")")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("centralManager did disconnect peripheral")
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("did update Value for executed")
        print(characteristic.description)
        guard let data = characteristic.value else { return }
        switch analyze(data: data).count {
        case 9: recievedData = analyze(data: data)
        case 4: batteryLevelData = analyze(data: data)
        default: return
        }
    }
}

extension DeviceManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
        print("did  DiscoverServices executed")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        let byteArray: [UInt8] = [ 0x00, 0x02, 0x01, 0x03]
        let data = Data(byteArray)
        let batteryLevelArray: [UInt8] = [0x00,0x03,0x00,0x03]
        let batteryLevelData = Data(batteryLevelArray)
        
        let modeSettingArray: [UInt8] = [0x01,0x00,0x01,0xF4,0x01,0xFF,0x9C,0x64,0x00,0x00,0x00,0x11,0x11,0x20,0x38]
        let modeSettingData = Data(modeSettingArray)
        
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            peripheral.setNotifyValue(true, for: characteristic)
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
            peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
        }
        print("did Discover Characteristics for executed")
        
        for characteristic in characteristics {
            peripheral.setNotifyValue(true, for: characteristic)
            peripheral.writeValue(batteryLevelData, for: characteristic, type: .withResponse)
            peripheral.writeValue(batteryLevelData, for: characteristic, type: .withoutResponse)
        }
        
        for characteristic in characteristics {
            peripheral.setNotifyValue(true, for: characteristic)
            peripheral.writeValue(modeSettingData, for: characteristic, type: .withResponse)
            peripheral.writeValue(modeSettingData, for: characteristic, type: .withoutResponse)
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("did Update Notification State For executed characteristic: \(characteristic.description)")
    }
}
