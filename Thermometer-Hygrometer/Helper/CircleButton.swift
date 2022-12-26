//
//  CircleButton.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/26.
//

import SwiftUI

struct CircleButton: View {
    var label: String
    
    var body: some View {
        Text(label)
             .font(.title3)
             .fontWeight(.bold)
             .padding(5)
             .frame(width: 120, height: 120)
             .foregroundColor(.primary)
             .overlay(
                 Circle()
                     .stroke(Color.primary, lineWidth: 1)
             )
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(label: "Sample")
    }
}
