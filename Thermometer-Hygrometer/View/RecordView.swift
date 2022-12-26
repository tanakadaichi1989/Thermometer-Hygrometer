//
//  RecordView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/25.
//

import SwiftUI
import CoreData

struct RecordView: View {
    @Environment(\.managedObjectContext) var recordViewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var records: FetchedResults<Record>
    @State private var isShowAlert = false
    
    var body: some View {
        VStack {
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
            .frame(height: UIScreen.main.bounds.height / 2)
            confirmButton
        }
    }
}

extension RecordView {
    private var confirmButton: some View {
        Button {
            self.isShowAlert = true
        } label: {
            Text("delete all records")
        }
        .alert(isPresented: $isShowAlert){
            Alert(
                title: Text("Confirm"),
                message: Text("Do you really want to delete all records?"),
                primaryButton: .destructive(Text("Execute delete All")){ deleteAll() },
                secondaryButton: .default(Text("Cancel"))
            )
        }
        .buttonStyle(.borderedProminent)
        .padding(50)
    }
    
    private func deleteAll(){
        print("deleteAll executed.")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = Record.entity()
        let records = try? recordViewContext.fetch(fetchRequest) as? [Record]
        for record in records! {
            recordViewContext.delete(record)
        }
        try! recordViewContext.save()
    }
}
