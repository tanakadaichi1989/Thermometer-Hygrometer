//
//  Extensions.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/23.
//

import Foundation

extension Double {
    static func convert(_ data1: Int, _ data2: Int) -> Double? {
        switch Double(data1) + Double(data2 * 256) {
        case 0.0: return 0.0
        case 0.1...500.0: return (Double(data1) + Double(data2 * 256)) / 10
        case 65436.0...65535.0: return (Double(data1) + Double(data2 * 256) - 65536.0) / 10
        default:
            return nil
        }
    }
}

extension String {
    static func format(_ date: Date?) -> String {
        guard let date = date else { return "-" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: date)
    }
}
