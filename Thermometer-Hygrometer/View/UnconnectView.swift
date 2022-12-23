//
//  UnconnectView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2022/12/20.
//

import SwiftUI

struct UnconnectView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("Let's get started.")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Image(systemName: "antenna.radiowaves.left.and.right.slash")
                .font(.system(size: 100))
                .padding(20)
            Text("How to connect MESH sensor")
                .font(.title3)
                .fontWeight(.bold)
                .padding(20)
            VStack(alignment: .leading) {
                Text("1. Switch on your sensor")
                    .padding(2)
                Text("2. Tap your sensor button. ")
                    .padding(2)
                Text("※ If success to connect your device and sensor, this App will change page.")
                    .font(.caption)
                    .padding(2)
                Text("3. Tap a \"connect\" button on the next page.")
                    .padding(2)
            }
        }
        .padding()
    }
}

struct UnconnectView_Previews: PreviewProvider {
    static var previews: some View {
        UnconnectView()
    }
}
