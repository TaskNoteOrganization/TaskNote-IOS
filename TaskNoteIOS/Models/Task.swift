//
//  Task.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation

/// Represents a user-created task in the system.
/// Each task may have a parent task (for subtasks), a due date, and a status.
public struct Task: Codable, Identifiable {
    
    /// Unique identifier for the task
    public let id: UUID
    
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
        return try JSONDecoder.supabaseDecoder.decode(Task.self, from: data)
    }
}

extension Task {
    static let mockTasks: [Task] = [
        Task(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            userId: UUID(uuidString: "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")!,
            title: "Finish onboarding flow",
            description: "Implement login, signup, and forgot password screens",
            status: "in_progress",
            dueDate: Date(timeIntervalSince1970: 1_700_500_000), // mid Jan 2024
            parentId: nil,
            createdAt: Date(timeIntervalSince1970: 1_700_000_000)
        ),
        Task(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            userId: UUID(uuidString: "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")!,
            title: "Write unit tests",
            description: nil,
            status: "pending",
            dueDate: nil,
            parentId: nil,
            createdAt: Date(timeIntervalSince1970: 1_705_000_000)
        ),
        Task(
            id: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
            userId: UUID(uuidString: "cccccccc-cccc-cccc-cccc-cccccccccccc")!,
            title: "Launch v1.0",
            description: "Public App Store release",
            status: "completed",
            dueDate: Date(timeIntervalSince1970: 1_710_000_000),
            parentId: UUID(uuidString: "44444444-4444-4444-4444-444444444444"), // Has parent (onboarding task)
            createdAt: Date(timeIntervalSince1970: 1_705_000_000)
        )
    ]
}
