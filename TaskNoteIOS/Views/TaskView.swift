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
    @State var someTask : Task
    
    var body: some View {
        
        NavigationStack{
            VStack
            {
                
                TopMiniBar(someTitle: someTask.title)
                
//                ZStack {
//                    HStack {
//                        Spacer()
//                        Text(someTask.title).font(.title)
//                        Spacer()
//                    }
//                    
//                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(Color.mainOpposite)
                    ScrollView {
                        Markdown(someTask.description ?? "")
                            .foregroundStyle(Color.base)
                    }.frame(height: UIScreen.main.bounds.height * 0.65)
                    
                }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.69)

                
                Spacer()
                HomeNavBar()
            }
        }.background(Color.bg4)
        .preferredColorScheme(colorMode.darkMode ? .dark : .light)
        .environmentObject(ColorSettings())
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    TaskView(someTask: Task.mockTasks[0])
        .environmentObject(ColorSettings(previewing : true))
}
