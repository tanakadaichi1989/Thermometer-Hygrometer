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
            if manager.hasDevice() {
                TabView {
                    MainView()
                        .tabItem {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                            Text("Sensor")
                        }
                    RecordView()
                        .tabItem {
                            Image(systemName: "waveform.and.magnifyingglass")
                            Text("Records")
                        }
                }
            } else {
                TabView {
                    UnconnectView()
                        .tabItem {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                            Text("Sensor")
                        }
                    RecordView()
                        .tabItem {
                            Image(systemName: "waveform.and.magnifyingglass")
                            Text("Records")
                        }
                }
            }
        }
    }
}
