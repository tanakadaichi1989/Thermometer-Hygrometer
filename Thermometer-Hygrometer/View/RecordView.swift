//
//  RecordView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/25.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.managedObjectContext) var recordViewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var records: FetchedResults<Record>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(records.count.description) records")
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
            .frame(height: UIScreen.main.bounds.height / 2)
            Spacer()
        }
    }
}
