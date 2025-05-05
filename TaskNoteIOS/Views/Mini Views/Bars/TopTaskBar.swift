//
//  TopTaskBar.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 5/4/25.
//

import SwiftUI

struct TopTaskBar: View {
    
    var someTitle : String
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Rectangle().foregroundStyle(Color.bg2)
                
                HStack {
                    
                    Spacer()
                    
                    BackButton()
                    
                    Spacer()
                    
                    ScrollView(.horizontal) {
                        
                        Text(someTitle).foregroundStyle(Color.main).fontWeight(.bold)
                            .font(.title2)
                        
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.05)
                    
                    
                    Spacer()
                    
                    NavigationLink{
                        NoteCreateView()
                    } label: {
                        MiscButton(someText: "Edit Task")
                    }
                    
                    Spacer()
                    
                }
                
            }.frame(height: UIScreen.main.bounds.height * 0.08)
                .preferredColorScheme(colorMode.darkMode ? .dark : .light)
        }
        
    }
}

#Preview {
    TopTaskBar(someTitle: "Test")
        .environmentObject(ColorSettings(previewing : true))
}
