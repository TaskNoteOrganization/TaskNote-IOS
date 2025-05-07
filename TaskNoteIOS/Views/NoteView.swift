//
//  NoteView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 5/1/25.
//

import SwiftUI
import MarkdownUI

struct NoteView: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    @State var someNote : Note
    
    var body: some View {
        
        NavigationStack{
            VStack
            {
                
                TopMiniBar(someTitle: someNote.title ?? "");

                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(Color.mainOpposite)
                    ScrollView {
                        Markdown("test")
                            .foregroundStyle(Color.base)
                    }.frame(height: UIScreen.main.bounds.height * 0.65)
                    
                }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.69)
                
                
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
