//
//  NoteTaskLink.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation

public struct NoteTaskLink: Codable {
    var noteId: UUID
    var taskId: UUID
    
    enum CodingKeys: String, CodingKey {
        case noteId = "note_id"
        case taskId = "task_id"
    }
    
    // Decode note task link from supabase json
    public static func decodeNoteTaskLink(from json: String) throws -> NoteTaskLink {
        let data = json.data(using: .utf8)!
        return try JSONDecoder.supabaseDecoder.decode(NoteTaskLink.self, from: data)
    }
}

extension NoteTaskLink {
    static let mockNoteTaskLinks: [NoteTaskLink] = [
        NoteTaskLink(
            noteId: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!, // matches first mock Note
            taskId: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!  // matches first mock Task
        ),
        NoteTaskLink(
            noteId: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            taskId: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!
        ),
        NoteTaskLink(
            noteId: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            taskId: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!
        )
    ]
}
