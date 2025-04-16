//
//  Reminder.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation

struct Reminder: Codable, Identifiable {
    let id: UUID
    let taskId: UUID
    let remindAt: Date
    let isSent: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case taskId = "task_id"
        case remindAt = "remind_at"
        case isSent = "is_sent"
    }
    
    public static func decodeReminder(from json: String) throws -> Reminder {
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Reminder.self, from: data)
    }
}
