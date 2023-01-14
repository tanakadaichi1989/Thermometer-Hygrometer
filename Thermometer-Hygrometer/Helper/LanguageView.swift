//
//  LanguageView.swift
//  Thermometer-Hygrometer
//
//  Created by 田中大地 on 2023/01/14.
//

import SwiftUI

struct LanguageView: View {
    @EnvironmentObject var manager: SettingManager
    var language: LanguageConstant
    
    var body: some View {
        HStack {
            Text(language.rawValue)
            Spacer()
            if isSelected() { Image(systemName: "checkmark").foregroundColor(.accentColor) }
        }
    }
}

extension LanguageView {
    private func isSelected() -> Bool {
        language == manager.language
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(language: LanguageConstant.English)
        LanguageView(language: LanguageConstant.Japanese)
    }
}
