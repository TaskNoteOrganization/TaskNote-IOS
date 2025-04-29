//
//  NoteButton.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/29/25.
//


import SwiftUI

struct NoteButton: View {
    
    var someNote : Note
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        
        HStack {
            ZStack {
                Rectangle().foregroundStyle(Color.bg3)
                
                Text(someNote.title ?? "some error").foregroundStyle(Color.main).fontWeight(.bold).font(.title3)
                
            }.frame(height: UIScreen.main.bounds.height * 0.06)
                .environmentObject(ColorSettings())
            Spacer()
        }
        
    }
}

#Preview {
    NoteButton(someNote: Note.mockNotes[0])
        .environmentObject(ColorSettings(previewing : true))
}
