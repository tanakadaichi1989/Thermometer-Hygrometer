//
//  TimerManager.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/25.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    var timer: Timer?
    
    func startTimer(completion: @escaping ( ) -> Void){
        if let timer = timer { timer.invalidate() }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            completion()
        }
    }
    
    func endTimer(completion: @escaping () -> Void){
        completion()
        if let timer = timer { timer.invalidate() }
    }
}
