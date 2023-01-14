//
//  LanguageSettingView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/14.
//

import SwiftUI

struct LanguageSettingView: View {
    @EnvironmentObject var manager: SettingManager
    var body: some View {
        NavigationStack {
            List {
                ForEach(LanguageConstant.allCases) { language in
                    LanguageView(language: language)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            manager.changeAppLanguage(selected: language)
                        }
                }
            }
        }
        .navigationTitle(Text("Language"))
    }
}

struct LanguageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSettingView()
    }
}
