//
//  TaskNoteIOSApp.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import SwiftUI

@main
struct TaskNoteIOSApp: App {
    @StateObject var supabase = SupabaseService.shared
    @StateObject var colorSettings = ColorSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(supabase)
                .environmentObject(colorSettings)
        }
    }
}



