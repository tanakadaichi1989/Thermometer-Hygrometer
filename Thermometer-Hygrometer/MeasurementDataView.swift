//
//  MeasurementDataView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/20.
//

import SwiftUI

struct MeasurementDataView: View {
    var data: String
    var type: MeasurementDataType
    
    var body: some View {
        HStack {
            Image(systemName: self.getSystemName(type: type))
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("\(self.data) \(self.getUnit(type: type))")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding()
    }
    
    private func getSystemName(type: MeasurementDataType) -> String {
        switch type {
        case .thermometer: return "thermometer.medium"
        case .hygrometer: return "humidity.fill"
        }
    }
    
    private func getUnit(type: MeasurementDataType) -> String {
        switch type {
        case .thermometer: return "℃"
        case .hygrometer: return "%"
        }
    }
    
    enum MeasurementDataType {
        case thermometer
        case hygrometer
    }
}

