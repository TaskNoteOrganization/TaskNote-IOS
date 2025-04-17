//
//  HomeNavBar.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct HomeNavBar: View {
    var body: some View {
        
        NavigationStack {
            
            ZStack
            {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(Color.gray)
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink{NoteListView()} label: {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.pink)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)
                    
                    Spacer()
                    
                    NavigationLink{TaskListView()} label: {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.pink)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)

                    
                    Spacer()
                    
                    NavigationLink{SettingsView()} label: {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.pink)
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.08)

                    
                    Spacer()
                    
                }
                
            }.frame(width: (UIScreen.main.bounds.width * 0.95), height: UIScreen.main.bounds.height * 0.1)
        }
        
    }
    
}

#Preview {
    HomeNavBar()
}
