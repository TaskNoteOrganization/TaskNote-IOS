//
//  TopMiniBar.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/20/25.
//

import SwiftUI

struct TopMiniBar: View {
    
    var someTitle : String
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        
        ZStack {
            Rectangle().foregroundStyle(Color.bg2)
            
            Text(someTitle).foregroundStyle(Color.main).fontWeight(.bold).font(.title)
            
        }.frame(height: UIScreen.main.bounds.height * 0.08)
            .preferredColorScheme(colorMode.darkMode ? .dark : .light)
            .environmentObject(ColorSettings())
        
    }
}

#Preview {
    TopMiniBar(someTitle: "Test")
        .environmentObject(ColorSettings(previewing : true))
}

