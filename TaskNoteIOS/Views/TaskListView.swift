//
//  TaskListView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    
    @State var someNoteList : [Note]
    @State var someTaskList : [Task]
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    TopMiniBar(someTitle: "Task and Notes List")
                    
                    VStack {
                        
                        HStack {
                            
                            Text("Current Tasks:").fontWeight(.bold).font(.title2)
                            Spacer()
                            
                        }
                        
                        ScrollView
                        {
                            ForEach(someTaskList) { element in
                                
                                NavigationLink(destination: TaskView(someTask: element), label: {TaskButton(someTask: element)})
                                
                            }
                        }.frame(height: UIScreen.main.bounds.height * 0.3)
                        
                    }
                    
                    VStack {
                        
                        HStack {
                            
                            Text("Recent Notes").fontWeight(.bold).font(.title2)
                            Spacer()
                            
                        }
                        
                        ScrollView{
                            ForEach(someNoteList) { element in
                                
                                NavigationLink(destination: NoteView(someNote: element), label: { NoteButton(someNote: element)} )
                                
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                
                HomeNavBar()
            }
            .padding()
            .background(Color.bg4)
            
        }.navigationBarBackButtonHidden(true)
            .preferredColorScheme(colorMode.darkMode ? .dark : .light)

    }
}

#Preview {
    TaskListView(someNoteList: Note.mockNotes, someTaskList: Task.mockTasks)
        .environmentObject(ColorSettings(previewing : true))
}
