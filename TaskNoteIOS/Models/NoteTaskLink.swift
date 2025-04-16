//
//  NoteTaskLink.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import Foundation

/// Represents the many-to-many relationship between a note and a task.
/// This is a link table model used to associate notes with tasks in Supabase.
struct NoteTaskLink: Codable {
    
    /// ID of the note
    var noteId: Int

    /// ID of the task the note is linked to
    var taskId: Int

    /// Maps Swift property names to Supabase's snake_case JSON structure
    enum CodingKeys: String, CodingKey {
        case noteId = "note_id"
        case taskId = "task_id"
    }

    /// Decodes a `NoteTaskLink` instance from a raw JSON string
    /// - Parameter json: A valid JSON string returned from Supabase
    /// - Returns: A decoded `NoteTaskLink` object
    public static func decodeNoteTaskLink(from json: String) throws -> NoteTaskLink {
        let data = json.data(using: .utf8)!
        return try JSONDecoder().decode(NoteTaskLink.self, from: data)
    }
}
