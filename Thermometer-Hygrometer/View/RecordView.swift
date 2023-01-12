//
//  RecordView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/25.
//

import SwiftUI
import CoreData
import RealmSwift

struct RecordView: View {
    @EnvironmentObject var recordManager: RecordManager
    @State private var isShowAlert = false
    
    var body: some View {
        VStack {
            if recordManager.records.count > 0 {
                Text("\(recordManager.records.count.description) \(getLevel(count: recordManager.records.count))")
                    .font(.title)
                    .fontWeight(.bold)
                List(recordManager.records){ record in
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
                .onAppear {
                    recordManager.records.sort { $0.date > $1.date }
                }
                .frame(height: UIScreen.main.bounds.height / 2)
                HStack {
                    exportConfirmButton
                    deleteConfirmButton
                }
            } else {
                Text("No measurement data")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
}

extension RecordView {
    private func getLevel(count: Int) -> String {
        count == 1 ? "record" : "records"
    }
    
    private var deleteConfirmButton: some View {
        Button {
            self.isShowAlert = true
        } label: {
            CircleButton(label: "delete\nall records")
        }
        .alert(isPresented: $isShowAlert){
            Alert(
                title: Text("Confirm"),
                message: Text("Do you really want to delete all records?"),
                primaryButton: .destructive(Text("Execute delete All")){ deleteAll() },
                secondaryButton: .default(Text("Cancel"))
            )
        }
        .padding()
    }
    
    private var exportConfirmButton: some View {
        Button {
            print(Realm.Configuration.defaultConfiguration.fileURL)
            shareData()
        } label: {
            CircleButton(label: "export\nall records")
        }
    }
    
    private func deleteAll(){
        recordManager.deleteAll()
    }
    
    private func shareData(){
        let activityItems = [Realm.Configuration.defaultConfiguration.fileURL!] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityVC, animated: true)
    }
}
