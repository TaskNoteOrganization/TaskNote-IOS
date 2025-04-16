//
//  NoteTaskLinkModelTests.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import Foundation
import Testing
@testable import TaskNoteIOS

@Suite("NoteTaskLink Model Tests")
struct NoteTaskLinkTests {
    
    @Test("Valid link decoding")
    func validLinkTest() throws {
        let json = """
        {
            "note_id": 1,
            "task_id": 42
        }
        """
        let data = json.data(using: .utf8)!
        let link = try JSONDecoder.supabaseDecoder.decode(NoteTaskLink.self, from: data)
        #expect(link.noteId == 1)
        #expect(link.taskId == 42)
    }
    
    @Test("Missing note_id should fail")
    func missingNoteIdTest() {
        let json = """
        {
            "task_id": 42
        }
        """
        let data = json.data(using: .utf8)!
        do {
            _ = try JSONDecoder.supabaseDecoder.decode(NoteTaskLink.self, from: data)
            #expect(Bool(false), "Expected decoding to fail for missing note_id")
        } catch {
            #expect(true)
        }
    }
    
    @Test("Null note_id should fail")
    func nullNoteIdTest() {
        let json = """
        {
            "note_id": null,
            "task_id": 42
        }
        """
        let data = json.data(using: .utf8)!
        do {
            _ = try JSONDecoder.supabaseDecoder.decode(NoteTaskLink.self, from: data)
            #expect(Bool(false), "Expected decoding to fail for null note_id")
        } catch {
            #expect(true)
        }
    }
    
    @Test("Missing task_id should fail")
    func missingTaskIdTest() {
        let json = """
        {
            "note_id": 99
        }
        """
        let data = json.data(using: .utf8)!
        do {
            _ = try JSONDecoder.supabaseDecoder.decode(NoteTaskLink.self, from: data)
            #expect(Bool(false), "Expected decoding to fail for missing task_id")
        } catch {
            #expect(true)
        }
    }
}
