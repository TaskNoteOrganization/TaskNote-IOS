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
    
    @State private var noteTitle: String = """
"""
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
                Button(action: {
                    _Concurrency.Task {
                        await submit()
                    }
                }){
                    Text("Submit").fontWeight(.semibold)
                }
            }
        }
        .padding()
    }
    
    private func preview(){
        isPreview.toggle()
    }
    
    private func submit() async {
        // TODO:
        // Code for empty title? / text
        
        // Package into data
        var filename = ""
        guard let data = noteText.data(using: .utf8) else {
            print("ERROR: Encoding failed")
            return
        }
        // Upload as md file
        do {
            let uuid = UUID()
            filename = "\(uuid.uuidString).md"
            let path = try await SupabaseService.shared.uploadMarkdownFile(data: data, filename: filename)
        } catch {
            print("Markdown upload failed: \(error)")
        }
        // Create note with path
        do {
            let uid = try await SupabaseService.shared.getCurrentUser()!
            _ = try await SupabaseService.shared.createNote(title: noteTitle, path: "\(uid)/\(filename)")
        } catch {
            print("Note creation failed: \(error)")
        }
        return
    }
}

#Preview {
    NoteCreateView()
}
