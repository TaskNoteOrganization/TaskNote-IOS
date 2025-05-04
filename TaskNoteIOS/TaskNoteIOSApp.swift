//
//  TaskNoteIOSApp.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import SwiftUI

@main
struct TaskNoteIOSApp: App {
    
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ColorSettings())
        }
    }
}
