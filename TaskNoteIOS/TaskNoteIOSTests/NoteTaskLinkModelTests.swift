//
//  NoteTaskLinkModelTests.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
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
        let link = try decodeNoteTaskLink(from: json)
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
        do {
            _ = try decodeNoteTaskLink(from: json)
            #expect(Bool(false), "Expected decoding to fail")
        } catch {
            #expect(Bool(true))
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
        do {
            _ = try decodeNoteTaskLink(from: json)
            #expect(Bool(false), "Expected decoding to fail")
        } catch {
            #expect(Bool(true))
        }
    }
    
    @Test("Missing task_id should fail")
    func missingTaskIdTest() {
        let json = """
        {
            "note_id": 99
        }
        """
        do {
            _ = try decodeNoteTaskLink(from: json)
            #expect(Bool(false), "Expected decoding to fail")
        } catch {
            #expect(Bool(true))
        }
    }
    
    // Shared decoding helper
    private func decodeNoteTaskLink(from json: String) throws -> NoteTaskLink {
        let data = json.data(using: .utf8)!
        return try JSONDecoder().decode(NoteTaskLink.self, from: data)
    }
}
