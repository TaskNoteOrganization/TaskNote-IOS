//
//  NoteListView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct NoteListView: View {
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    ZStack {
                        Rectangle().foregroundStyle(Color.gray)
                        
                        Text("Note List").foregroundStyle(Color.white).fontWeight(.bold)
                        
                    }.frame(height: UIScreen.main.bounds.height * 0.05)
                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                    
                    Spacer()
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                    .defaultScrollAnchor(.top)
                
                
                // Spacer()
                
                HomeNavBar()
            }
            .padding()
            
        }.navigationBarBackButtonHidden(true)

    }
}

#Preview {
    NoteListView()
}
