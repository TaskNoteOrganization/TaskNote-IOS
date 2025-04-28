//
//  ContentView.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import SwiftUI

class ColorSettings: ObservableObject {
    @Published var darkMode : Bool = true
}

struct ContentView: View {
    
    @EnvironmentObject var darkMode: ColorSettings
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                // Spacer()
                
                HomeNavBar()
            }
            .padding()
            
        }
        .environmentObject(ColorSettings())
    }
}

#Preview {
    ContentView()
}
