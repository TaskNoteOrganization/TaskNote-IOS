//
//  NoteListView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct NoteListView: View {
    
    @State var darkMode : Bool
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    TopMiniBar(someTitle: "Note List", darkMode: darkMode)
                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                    
                    Spacer()
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                    .defaultScrollAnchor(.top)
                
                
                // Spacer()
                
                HomeNavBar(darkMode: darkMode)
            }
            .padding()
            
        }.navigationBarBackButtonHidden(true)

    }
}

#Preview {
    NoteListView(darkMode: true)
}
