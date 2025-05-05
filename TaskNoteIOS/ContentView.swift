//
//  ContentView.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import SwiftUI

public final class ColorSettings: ObservableObject {
    @Published var darkMode : Bool = true
    
    init(previewing: Bool = false) {
        if previewing {
            darkMode = true
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        
        NoteListView(someNoteList: Note.mockNotes)

    }
}

#Preview {
    ContentView()
        .environmentObject(ColorSettings(previewing : true))
    
}
