//
//  Record+CoreDataProperties.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/09.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var batteryLevel: Double
    @NSManaged public var date: Date?
    @NSManaged public var deviceName: String?
    @NSManaged public var humidityPercent: Double
    @NSManaged public var id: UUID?
    @NSManaged public var temperatureCelsius: Double

}

extension Record : Identifiable {

}
