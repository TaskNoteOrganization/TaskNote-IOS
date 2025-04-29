//
//  Reminder.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation

/// Represents a time-based reminder linked to a specific task.
/// A reminder is scheduled for a specific `remindAt` timestamp and can be marked as sent.
public struct Reminder: Codable, Identifiable {
    
    /// Unique identifier for the reminder
    public let id: UUID
    
    /// The ID of the task this reminder is associated with
    let taskId: UUID
    
    /// The timestamp when the user should be reminded
    let remindAt: Date
    
    /// Whether the reminder has already been sent (e.g., via notification)
    let isSent: Bool
    
    /// Maps Swift property names to Supabase's snake_case JSON structure
    enum CodingKeys: String, CodingKey {
        case id
        case taskId = "task_id"
        case remindAt = "remind_at"
        case isSent = "is_sent"
    }
    
    /// Decodes a `Reminder` instance from a raw JSON string
    /// - Parameter json: A valid JSON string returned from Supabase
    /// - Returns: A decoded `Reminder` object
    public static func decodeReminder(from json: String) throws -> Reminder {
        let data = json.data(using: .utf8)!
        return try JSONDecoder.supabaseDecoder.decode(Reminder.self, from: data)
    }
}

extension Reminder {
    static let mockReminders: [Reminder] = [
        Reminder(
            id: UUID(uuidString: "77777777-7777-7777-7777-777777777777")!,
            taskId: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            remindAt: Date(timeIntervalSince1970: 1_700_600_000), // 1 hour after first task creation
            isSent: false
        ),
        Reminder(
            id: UUID(uuidString: "88888888-8888-8888-8888-888888888888")!,
            taskId: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            remindAt: Date(timeIntervalSince1970: 1_700_800_000),
            isSent: true
        ),
        Reminder(
            id: UUID(uuidString: "99999999-9999-9999-9999-999999999999")!,
            taskId: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
            remindAt: Date(timeIntervalSince1970: 1_701_000_000),
            isSent: false
        )
    ]
}
