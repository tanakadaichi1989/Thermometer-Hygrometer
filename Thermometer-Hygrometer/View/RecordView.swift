//
//  RecordView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/25.
//

import SwiftUI
import CoreData

struct RecordView: View {
    @State private var isShowAlert = false
    
    var body: some View {
        VStack {
            Text("Saving measurement data function will be provided in the future.")
                .padding()
            /*
            Text("\(records.count.description) records")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            List(records){ record in
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(String(format: "%.1f",record.temperatureCelsius)) ℃")
                        Text("\(String(format: "%.0f",record.humidityPercent)) %")
                    }
                    HStack {
                        Text(String.format(record.date))
                        Text(record.deviceName ?? "unnamed device")
                    }
                    .font(.caption)
                    .fontWeight(.thin)
                }
            }
            .padding()
            .frame(height: UIScreen.main.bounds.height / 2)
            confirmButton
             */
        }
    }
}
