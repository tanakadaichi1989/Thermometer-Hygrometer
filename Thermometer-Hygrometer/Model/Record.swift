//
//  Record.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/09.
//

import Foundation
import RealmSwift

final class Record: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var date: Date
    @Persisted var deviceName: String
    @Persisted var temperatureCelsius: Double
    @Persisted var humidityPercent: Double
    @Persisted var batteryLevel: Double
    
    override init(){}
    
    init(date: Date, deviceName:String, temperatureCelsius:Double, humidityPercent:Double, batteryLevel:Double){
        self.date = date
        self.deviceName = deviceName
        self.temperatureCelsius = temperatureCelsius
        self.humidityPercent = humidityPercent
        self.batteryLevel = batteryLevel
    }
}
