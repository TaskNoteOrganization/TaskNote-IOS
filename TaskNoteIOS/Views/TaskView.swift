//
//  NoteView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 5/1/25.
//

import SwiftUI

struct TaskView: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    @State var someTask : Task
    
    var body: some View {
        
        NavigationStack{
            VStack
            {
                
                ZStack {
                    HStack {
                        Spacer()
                        Text(someTask.title)
                        Spacer()
                    }
                }
                
                Spacer()
                HomeNavBar()
            }
        }.background(Color.bg4)
        .environmentObject(ColorSettings())
        
    }
}

#Preview {
    TaskView(someTask: Task.mockTasks[0])
        .environmentObject(ColorSettings(previewing : true))
}
