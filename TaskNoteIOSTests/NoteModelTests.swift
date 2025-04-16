//
//  NoteModelTests.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation
import Testing
@testable import TaskNoteIOS

@Suite("Note Model Tests")
struct NoteModelTests {
    
    @Test("Note with full data")
    func noteFullDataTest() throws {
        let iso = ISO8601DateFormatter()
        let json = """
            {
                "id": "\(UUID())",
                "user_id": "\(UUID())",
                "title": "Linked Note",
                "file_path": "tasknotes-notes/user-id/note-1.md",
                "created_at": "\(iso.string(from: Date()))"
            }
            """
        let note = try Note.decodeNote(from: json)
        #expect(note.title == "Linked Note")
        #expect(note.filePath.contains("note-1.md"))
    }
    
    @Test("Note with null title")
    func noteNullTitleTest() throws {
        let iso = ISO8601DateFormatter()
        let json = """
            {
                "id": "\(UUID())",
                "user_id": "\(UUID())",
                "title": null,
                "file_path": "tasknotes-notes/user-id/note-2.md",
                "created_at": "\(iso.string(from: Date()))"
            }
            """
        let note = try Note.decodeNote(from: json)
        #expect(note.title == nil)
    }
    
    @Test("Note with missing optional title")
    func noteMissingTitleTest() throws {
        let iso = ISO8601DateFormatter()
        let json = """
            {
                "id": "\(UUID())",
                "user_id": "\(UUID())",
                "file_path": "tasknotes-notes/user-id/note-3.md",
                "created_at": "\(iso.string(from: Date()))"
            }
            """
        let note = try Note.decodeNote(from: json)
        #expect(note.title == nil)
    }
    
    @Test("Note with only required fields")
    func noteMinimalDataTest() throws {
        let iso = ISO8601DateFormatter()
        let json = """
            {
                "id": "\(UUID())",
                "user_id": "\(UUID())",
                "file_path": "tasknotes-notes/user-id/note-4.md",
                "created_at": "\(iso.string(from: Date()))"
            }
            """
        let note = try Note.decodeNote(from: json)
        #expect(note.filePath.contains("note-4.md"))
    }
}
