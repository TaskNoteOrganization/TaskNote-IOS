//
//  Note.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation

/// Represents a note owned by a user.
/// The actual content of the note is stored in Supabase Storage, and referenced via `filePath`.
public struct Note: Codable, Identifiable {
    
    /// Unique identifier for the note
    public let id: UUID
    
    /// ID of the user who owns the note (foreign key to `auth.users`)
    let userId: UUID
    
    /// Optional title or label for the note
    let title: String?
    
    /// Path to the note file in Supabase Storage (e.g., `"tasknotes-notes/user-id/note.md"`)
    let filePath: String
    
    /// Timestamp for when the note was created
    let createdAt: Date
    
    /// Maps Swift property names to Supabase's snake_case JSON structure
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case filePath = "file_path"
        case createdAt = "created_at"
    }
    
    /// Decodes a `Note` instance from a raw JSON string
    /// - Parameter json: A valid JSON string returned from Supabase
    /// - Returns: A decoded `Note` object
    public static func decodeNote(from json: String) throws -> Note {
        let data = json.data(using: .utf8)!
        return try JSONDecoder.supabaseDecoder.decode(Note.self, from: data)
    }
}
