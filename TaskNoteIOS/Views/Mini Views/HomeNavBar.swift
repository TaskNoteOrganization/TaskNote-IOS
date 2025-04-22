//
//  HomeNavBar.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct HomeNavBar: View {
    
    @State var darkMode : Bool
    
    var body: some View {
        
        NavigationStack {
            
            ZStack
            {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(Color.bg2)
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink{NoteListView(darkMode: darkMode)} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.mainOpposite)
                            
                            Image(systemName: "house")
                                .imageScale(.large)
                                .foregroundStyle(Color.main)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)
                    
                    Spacer()
                    
                    NavigationLink{TaskListView(darkMode: darkMode)} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.mainOpposite)
                            
                            Image(systemName: "checkmark.square")
                                .imageScale(.large)
                                .foregroundStyle(Color.main)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)

                    
                    Spacer()
                    
                    NavigationLink{SettingsView(darkMode: darkMode)} label: {
                        
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
        
    }
    
}

#Preview {
    HomeNavBar(darkMode: true)
}
