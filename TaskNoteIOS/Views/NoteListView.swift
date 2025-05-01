//
//  NoteListView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct NoteListView: View {
    
    @State var someNoteList : [Note]
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    TopMiniBar(someTitle: "Note List")
                    
                    ScrollView {
                        ForEach(someNoteList) { element in
                            
                            NavigationLink(destination: NoteView(someNote: element), label: { NoteButton(someNote: element)} )
                            
                        }
                    }
                    
                    Spacer()
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                    .defaultScrollAnchor(.top)
                
                
                // Spacer()
                
                HomeNavBar()
            }
            .padding()
            .background(Color.bg4)
            
        }.navigationBarBackButtonHidden(true)
            .environmentObject(ColorSettings())

    }
}

#Preview {
    NoteListView(someNoteList: Note.mockNotes)
        .environmentObject(ColorSettings(previewing : true))
}
