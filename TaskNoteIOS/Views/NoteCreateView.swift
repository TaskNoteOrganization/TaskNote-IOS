//
//  NoteCreateView.swift
//  TaskNoteIOS
//
//  Created by Adrian Haro on 4/17/25.
//

import SwiftUI
import Supabase
import MarkdownUI

struct NoteCreateView: View {
    
    @State private var noteTitle: String = ""
    @State private var noteText: String = ""
    @State private var isPreview: Bool = false
    
    var body: some View {
        VStack {
            TextField("Note Title", text: $noteTitle).font(.system(size: 26)).fontWeight(.semibold)
            ZStack {
                // The editing field
                VStack {
                    TextEditor(text: $noteText)
                        .frame(height: 500.0, alignment: .top).monospaced()
                        .keyboardType(.asciiCapable).font(.system(size: 15))
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                }.opacity(isPreview ? 0 : 1)
                // The Markdown preview
                VStack {
                    Markdown(noteText).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    
                }.opacity(isPreview ? 1 : 0)
                    .frame(height: 500.0)
            }
            HStack {
                Button(action: preview){
                    Text(isPreview ? "Continue Editing" : "Preview")
                }
                Spacer()
                Button(action: submit){
                    Text("Submit")
                }
            }
        }
        .padding()
    }
    
    func preview(){
        isPreview.toggle()
    }
    
    func submit(){
        // TODO
        return
    }
}

#Preview {
    NoteCreateView()
}
