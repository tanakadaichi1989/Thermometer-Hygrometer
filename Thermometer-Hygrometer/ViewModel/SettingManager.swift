//
//  SettingManager.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/14.
//

import Foundation

class SettingManager: ObservableObject {
    var language: LanguageConstant {
        didSet {
            print("Now App Language: \(self.language)")
        }
    }
    
    init(){
        self.language = LanguageConstant.English
    }
    
    func changeAppLanguage(){
        
    }
}
