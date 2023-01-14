//
//  LanguageConstant.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/14.
//

import Foundation

enum LanguageConstant: String, CaseIterable, Identifiable {
    case English = "English"
    case Japanese = "Japanese"
    var id: String { rawValue }
}
