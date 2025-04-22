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
                    .foregroundStyle(Color.gray)
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink{NoteListView(darkMode: darkMode)} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.pink)
                            
                            Image(systemName: "house")
                                .imageScale(.large)
                                .foregroundStyle(Color.white)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)
                    
                    Spacer()
                    
                    NavigationLink{TaskListView(darkMode: darkMode)} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.pink)
                            
                            Image(systemName: "checkmark.square")
                                .imageScale(.large)
                                .foregroundStyle(Color.white)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)

                    
                    Spacer()
                    
                    NavigationLink{SettingsView(darkMode: darkMode)} label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.pink)
                            
                            Image(systemName: "gear")
                                .imageScale(.large)
                                .foregroundStyle(Color.white)
                            
                            
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
