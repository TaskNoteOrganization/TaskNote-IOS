//
//  TaskNoteIOSApp.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import SwiftUI
import Foundation

@main
struct TaskNoteIOSApp: App {
    
    @StateObject private var supabaseService = SupabaseService.shared
    @StateObject private var colorSettings = ColorSettings()
    
    
    var body: some Scene {
        WindowGroup {
            if supabaseService.currentSession != nil {
                NoteListView()
                    .environmentObject(colorSettings)
            } else {
                LoginView()
                    .environmentObject(colorSettings)
            }
        }
    }
}

