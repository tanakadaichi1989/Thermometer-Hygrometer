//
//  SettingView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/14.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var manager: SettingManager
    
    var body: some View {
            NavigationStack {
                List {
                    NavigationLink(destination: LanguageSettingView()){
                       Text("Language")
                    }
                }
                .navigationTitle(Text("Settings"))
            }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
