//
//  ContentView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: DeviceManager
    @FetchRequest(sortDescriptors: []) var records: FetchedResults<Record>
    
    var body: some View {
        VStack {
            if manager.hasDevice() {
                MainView()
            } else {
                UnconnectView()
            }
        }
    }
}
