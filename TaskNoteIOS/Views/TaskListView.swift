//
//  TaskListView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct TaskListView: View {
    
    @State var darkMode : Bool
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    TopMiniBar(someTitle: "Task and Notes List", darkMode: darkMode)
                    
                    VStack {
                        
                        HStack {
                            
                            Text("Current Tasks:").fontWeight(.bold).font(.title2)
                            Spacer()
                            
                        }
                        
                        ScrollView
                        {
                            
                        }.frame(height: UIScreen.main.bounds.height * 0.3)
                        
                    }
                    
                    VStack {
                        
                        HStack {
                            
                            Text("Recent Notes").fontWeight(.bold).font(.title2)
                            Spacer()
                            
                        }
                        
                        ScrollView {
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                
                HomeNavBar(darkMode: darkMode)
            }
            .padding()
            
        }.navigationBarBackButtonHidden(true)

    }
}

#Preview {
    TaskListView(darkMode: true)
}
