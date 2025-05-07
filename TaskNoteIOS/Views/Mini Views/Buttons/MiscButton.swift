//
//  MiscButton.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 5/4/25.
//

import SwiftUI

struct MiscButton: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    
    @State var someText : String
    
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerSize: CGSize.init(width: 30.0, height: 30.0)).foregroundStyle(Color.bg3)
            
            Text(someText).foregroundStyle(Color.main).fontWeight(.bold).font(.title3)
            
        }.frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
            .preferredColorScheme(colorMode.darkMode ? .dark : .light)
        
    }
}

#Preview {
    MiscButton(someText: "Test")
        .environmentObject(ColorSettings(previewing : true))
}
