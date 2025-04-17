//
//  SettingsView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                
                // Spacer()
                
                HomeNavBar()
            }
            .padding()
            
        }
        
    }
}

#Preview {
    SettingsView()
}
