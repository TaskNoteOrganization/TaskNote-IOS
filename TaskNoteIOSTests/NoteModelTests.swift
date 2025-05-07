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
    
    private var formatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    private func iso(_ date: Date = Date()) -> String {
        formatter.string(from: date)
    }
    
    @Test("Note Model - Note with full data")
    func noteFullDataTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "Linked Note",
            "file_path": "tasknotes-notes/user-id/note-1.md",
            "created_at": "\(iso())"
        }
        """
        let note = try JSONDecoder.supabaseDecoder.decode(Note.self, from: json.data(using: .utf8)!)
        #expect(note.title == "Linked Note")
        #expect(note.filePath.contains("note-1.md"))
    }
    
    @Test("Note Model - Note with null title")
    func noteNullTitleTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": null,
            "file_path": "tasknotes-notes/user-id/note-2.md",
            "created_at": "\(iso())"
        }
        """
        let note = try JSONDecoder.supabaseDecoder.decode(Note.self, from: json.data(using: .utf8)!)
        #expect(note.title == nil)
    }
    
    @Test("Note Model - Note with missing optional title")
    func noteMissingTitleTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "file_path": "tasknotes-notes/user-id/note-3.md",
            "created_at": "\(iso())"
        }
        """
        let note = try JSONDecoder.supabaseDecoder.decode(Note.self, from: json.data(using: .utf8)!)
        #expect(note.title == nil)
    }
    
    @Test("Note Model - Note with only required fields")
    func noteMinimalDataTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "file_path": "tasknotes-notes/user-id/note-4.md",
            "created_at": "\(iso())"
        }
        """
        let note = try JSONDecoder.supabaseDecoder.decode(Note.self, from: json.data(using: .utf8)!)
        #expect(note.filePath.contains("note-4.md"))
    }
}
