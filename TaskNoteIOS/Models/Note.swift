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

extension Note {
    static let mockNotes: [Note] = [
        Note(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            userId: UUID(uuidString: "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")!,
            title: "First Note",
            filePath: "tasknotes-notes/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa/first-note.md",
            createdAt: Date(timeIntervalSince1970: 1_700_000_000) // Jan 2024
        ),
        Note(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            userId: UUID(uuidString: "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")!,
            title: "Second Note",
            filePath: "tasknotes-notes/bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb/second-note.md",
            createdAt: Date(timeIntervalSince1970: 1_705_000_000) // Feb 2024
        ),
        Note(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            userId: UUID(uuidString: "cccccccc-cccc-cccc-cccc-cccccccccccc")!,
            title: nil, // No title
            filePath: "tasknotes-notes/cccccccc-cccc-cccc-cccc-cccccccccccc/untitled-note.md",
            createdAt: Date(timeIntervalSince1970: 1_710_000_000) // March 2024
        )
    ]
}
