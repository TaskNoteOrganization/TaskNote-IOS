//
//  HomeNavBar.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct HomeNavBar: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        
        NavigationStack {
            
            ZStack
            {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(Color.bg2)
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink{NoteListView(someNoteList : Note.mockNotes)} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.mainOpposite)
                            
                            Image(systemName: "house")
                                .imageScale(.large)
                                .foregroundStyle(Color.main)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)
                    
                    Spacer()
                    
                    NavigationLink{TaskListView(someNoteList: Note.mockNotes)} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.mainOpposite)
                            
                            Image(systemName: "checkmark.square")
                                .imageScale(.large)
                                .foregroundStyle(Color.main)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)

                    
                    Spacer()
                    
                    NavigationLink{SettingsView()} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.mainOpposite)
                            
                            Image(systemName: "gear")
                                .imageScale(.large)
                                .foregroundStyle(Color.main)
                            
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)

                    
                    Spacer()
                    
                }
                
            }.frame(width: (UIScreen.main.bounds.width * 0.95), height: UIScreen.main.bounds.height * 0.1)
        }
        .environmentObject(ColorSettings())
        
    }
    
}

#Preview {
    HomeNavBar()
        .environmentObject(ColorSettings(previewing : true))
}
