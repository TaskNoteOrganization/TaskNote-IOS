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
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try JSONDecoder.supabaseDecoder.decode(Reminder.self, from: data)
    }
}
