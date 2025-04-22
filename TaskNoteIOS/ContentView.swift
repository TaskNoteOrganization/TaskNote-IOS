//
//  ContentView.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import SwiftUI

struct ContentView: View {
    
    @State var darkMode: Bool = true
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                // Spacer()
                
                HomeNavBar(darkMode: darkMode)
            }
            .padding()
            
        }
    }
}

#Preview {
    ContentView()
}
