//
//  NoteButton.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/29/25.
//


import SwiftUI

struct TaskButton: View {
    
    var someTask : Task
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        
        HStack {
            Spacer()
            ZStack {
                Rectangle().foregroundStyle(Color.bg3)
                
                HStack{
                    
                    Spacer()
                    
                    Text(someTask.title).foregroundStyle(Color.main).fontWeight(.bold).font(.title3)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    TaskStatusIcon(someTaskState: someTask.status)
                    Spacer()
                    
                }
                
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.06)
                .environmentObject(ColorSettings())
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        
    }
}

// Small struct t handle the gathering of a icon based on completion status
struct TaskStatusIcon: View {
    
    var someTaskState : String
    
    @EnvironmentObject var colorMode: ColorSettings
    
    var body: some View {
        VStack {
            Image(systemName: getStatusIcon(someString: someTaskState))
                .imageScale(.large)
                .foregroundStyle(Color.main)
        }.environmentObject(ColorSettings())
    }
    
}

func getStatusIcon(someString : String) -> String {
    
    switch someString {
//    case <#pattern#>:
//        <#code#>
    default:
        return "questionmark.circle"
    }
    
}

#Preview {
    TaskButton(someTask: Task.mockTasks[0])
        .environmentObject(ColorSettings(previewing : true))
}
