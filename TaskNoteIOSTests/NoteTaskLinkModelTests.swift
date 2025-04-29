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
    
    @Test("NoteTaskLink Model - Valid link decoding")
    func validLinkTest() throws {
        let noteUUID = UUID()
        let taskUUID = UUID()
        
        let json = """
        {
            "note_id": "\(noteUUID.uuidString)",
            "task_id": "\(taskUUID.uuidString)"
        }
        """
        let data = json.data(using: .utf8)!
        let link = try JSONDecoder.supabaseDecoder.decode(NoteTaskLink.self, from: data)
        
        #expect(link.noteId == noteUUID)
        #expect(link.taskId == taskUUID)
    }
    
    @Test("NoteTaskLink Model - Missing note_id should fail")
    func missingNoteIdTest() {
        let json = """
        {
            "task_id": "\(UUID().uuidString)"
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
    
    @Test("NoteTaskLink Model - Null note_id should fail")
    func nullNoteIdTest() {
        let json = """
        {
            "note_id": null,
            "task_id": "\(UUID().uuidString)"
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
    
    @Test("NoteTaskLink Model - Missing task_id should fail")
    func missingTaskIdTest() {
        let json = """
        {
            "note_id": "\(UUID().uuidString)"
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
