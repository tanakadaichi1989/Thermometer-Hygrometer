//
//  DeviceBatteryView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/19.
//

import SwiftUI

struct DeviceBatteryView: View {
    var batteryLevel: Int
    var body: some View {
        HStack(spacing: 1) {
            Text("\(batteryLevel * 10) %")
                .font(.subheadline)
                .fontWeight(.thin)
            Image(systemName: getImageSystemName(batteryLevel: batteryLevel))
                .font(.subheadline)
                .fontWeight(.thin)
        }
    }
    
    private func getImageSystemName(batteryLevel: Int) -> String {
        switch batteryLevel {
            case 10: return "battery.100"
            case 9,8,7: return "battery.75"
            case 6,5,4: return "battery.50"
            case 3,2,1: return "battery.25"
            case 0: return "battery.0"
            default: return "questionmark.circle"
        }
    }
}

struct DeviceBatteryView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceBatteryView(batteryLevel: 10)
    }
}
