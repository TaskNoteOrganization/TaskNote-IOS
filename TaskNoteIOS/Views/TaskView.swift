//
//  NoteView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 5/1/25.
//

import SwiftUI
import MarkdownUI

struct TaskView: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var someTask : Task
    
    var body: some View {
        
        NavigationStack{
            VStack
            {
                
                TopTaskBar(someTitle: someTask.title)
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(Color.mainOpposite)
                    ScrollView {
                        Markdown(someTask.description ?? "")
                            .foregroundStyle(Color.base)
                    }.frame(height: UIScreen.main.bounds.height * 0.45)
                    
                }.frame(width: UIScreen.main.bounds.width * 0.88, height: UIScreen.main.bounds.height * 0.5)
                
                Spacer()
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(Color.bg3)
                    
                    ScrollView {
                        VStack {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10.0)
                                    .foregroundStyle(Color.bg2)
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("Status: ")
                                    Text(someTask.status)
                                    
                                    Spacer()
                                    
                                    TaskStatusIcon(someTaskState: someTask.status)
                                    
                                    Spacer()
                                    
                                }
                                
                            }.frame(height: UIScreen.main.bounds.height * 0.05)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10.0)
                                    .foregroundStyle(Color.bg2)
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("Due Date: ")
                                    Text(someTask.dueDate?.formatted(.iso8601.day().month().year() ) ?? "No due date")
                                    
                                    Spacer()
                                    
                                }
                                
                            }.frame(height: UIScreen.main.bounds.height * 0.05)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10.0)
                                    .foregroundStyle(Color.bg2)
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("Creation Date: ")
                                    Text(someTask.createdAt.formatted(.iso8601.day().month().year() ))
                                    
                                    Spacer()
                                    
                                }
                                
                            }.frame(height: UIScreen.main.bounds.height * 0.05)
                            
                        }
                    }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.18)
                    
                }.frame(width: UIScreen.main.bounds.width * 0.88, height: UIScreen.main.bounds.height * 0.2)
                
                Spacer()
                HomeNavBar()
            }
        }.background(Color.bg4)
        .preferredColorScheme(colorMode.darkMode ? .dark : .light)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    TaskView(someTask: Task.mockTasks[0])
        .environmentObject(ColorSettings(previewing : true))
}
