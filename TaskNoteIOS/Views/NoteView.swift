//
//  NoteView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 5/1/25.
//

import SwiftUI

struct NoteView: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    @State var someNote : Note
    
    var body: some View {
        
        NavigationStack{
            VStack
            {
                
                ZStack {
                    HStack {
                        Spacer()
                        Text(someNote.title ?? "No title...")
                        Spacer()
                    }
                }
                
                
                Spacer()
                HomeNavBar()
            }
        }.background(Color.bg4)
        .preferredColorScheme(colorMode.darkMode ? .dark : .light)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    NoteView(someNote: Note.mockNotes[0])
        .environmentObject(ColorSettings(previewing : true))
}
