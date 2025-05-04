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
            Spacer()
            ZStack {
                Rectangle().foregroundStyle(Color.bg3)
                
                HStack{
                    
                    Spacer()
                    
                    Text(someNote.title ?? "some error").foregroundStyle(Color.main).fontWeight(.bold).font(.title3)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                }
                
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.06)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .preferredColorScheme(colorMode.darkMode ? .dark : .light)
        
    }
}

#Preview {
    NoteButton(someNote: Note.mockNotes[0])
        .environmentObject(ColorSettings(previewing : true))
}
