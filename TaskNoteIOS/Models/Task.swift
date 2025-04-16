//
//  Task.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import Foundation

/// Represents a user-created task in the system.
/// Each task may have a parent task (for subtasks), a due date, and a status.
struct Task: Codable, Identifiable {
    
    /// Unique identifier for the task
    let id: UUID

    /// ID of the user who owns this task (foreign key to auth.users)
    let userId: UUID

    /// Title of the task
    let title: String

    /// Optional description or notes for the task
    let description: String?

    /// Current status: "pending", "in_progress", or "completed"
    let status: String

    /// Optional due date for the task
    let dueDate: Date?

    /// Optional parent task ID (if this is a subtask)
    let parentId: UUID?

    /// Timestamp for when the task was created
    let createdAt: Date

    /// Maps Swift's camelCase keys to Supabase's snake_case JSON structure
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case description
        case status
        case dueDate = "due_date"
        case parentId = "parent_id"
        case createdAt = "created_at"
    }

    /// Decodes a `Task` instance from a raw JSON string
    /// - Parameter json: A valid JSON string returned from Supabase
    /// - Returns: A decoded `Task` object
    public static func decodeTask(from json: String) throws -> Task {
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Task.self, from: data)
    }
}
