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
    
    @StateObject var darkMode = ColorSettings()
    
    var body: some View {
        
        NoteListView()
    }
}

#Preview {
    ContentView()
}
