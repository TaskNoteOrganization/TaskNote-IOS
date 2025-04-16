//
//  NoteTaskLink.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation

struct NoteTaskLink: Codable {
    var noteId: Int
    var taskId: Int
    
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
