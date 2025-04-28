//
//  NoteListView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct NoteListView: View {
    
    @EnvironmentObject var darkMode: ColorSettings
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    TopMiniBar(someTitle: "Note List")
                    
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
            .background(Color.bg3)
            
        }.navigationBarBackButtonHidden(true)
            .environmentObject(ColorSettings())

    }
}

#Preview {
    NoteListView()
}
