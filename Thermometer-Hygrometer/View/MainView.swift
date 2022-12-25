//
//  ContentView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import SwiftUI
import CoreData

struct MainView: View {
    @EnvironmentObject var manager: DeviceManager
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var records: FetchedResults<Record>
    @State var isSave: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text(String.format(Date()))
                    .font(.title3)
                    .fontWeight(.bold)
                VStack {
                    if manager.recievedData.count != 0 {
                        MeasurementDataView(data: Double.convert(manager.recievedData[4],manager.recievedData[5]), type: .thermometer)
                        MeasurementDataView(data: Double(manager.recievedData[6]), type: .hygrometer)
                    } else {
                        MeasurementDataView(data: nil, type: .thermometer)
                        MeasurementDataView(data: nil, type: .hygrometer)
                    }
                }
                .padding()
                HStack {
                    Text("Save measurement data")
                    Toggle("", isOn: $isSave)
                        .labelsHidden()
                }
                .padding()
                HStack {
                    DeviceConnectButtonView(label: "Connect", peripheral: manager.devices[0].peripheral, type: .connect)
                    DeviceConnectButtonView(label: "Disconnect", peripheral: manager.devices[0].peripheral, type: .disConnect)
                }
                Text(manager.devices[0].peripheral.name ?? "unnamed device")
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .padding(1)
                if manager.batteryLevelData.count > 0 {
                    DeviceBatteryView(batteryLevel: manager.batteryLevelData[2])
                }
            }
        }
        .onAppear {
            self.startTimer()
        }
    }
}

extension MainView {
    /*
     private func deleteAll(){
     print("deleteAll executed.")
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
     fetchRequest.entity = Record.entity()
     let records = try? viewContext.fetch(fetchRequest) as? [Record]
     for record in records! {
     viewContext.delete(record)
     }
     try! viewContext.save()
     }
     */
    
    private func startTimer(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            print("executed startTimer")
            if isSave { self.saveData() }
        }
    }
    
    private func saveData(){
        print("executed saveData")
    }
}
