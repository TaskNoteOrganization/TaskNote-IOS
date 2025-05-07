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

    @EnvironmentObject var supabase: SupabaseService
    @EnvironmentObject var colorMode: ColorSettings

    var body: some View {
        Group {
            if supabase.currentSession != nil {
                NoteListView(someNoteList: Note.mockNotes)
            } else {
                LoginView()
            }
        }
        .preferredColorScheme(colorMode.darkMode ? .dark : .light)
    }
}

