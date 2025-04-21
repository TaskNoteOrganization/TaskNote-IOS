//
//  TaskListView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct TaskListView: View {
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    ZStack {
                        Rectangle().foregroundStyle(Color.gray)
                        
                        Text("Task List").foregroundStyle(Color.white).fontWeight(.bold)
                        
                    }.frame(height: UIScreen.main.bounds.height * 0.05)
                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                    
                    Spacer()
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                
                HomeNavBar()
            }
            .padding()
            
        }.navigationBarBackButtonHidden(true)

    }
}

#Preview {
    TaskListView()
}
