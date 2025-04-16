//
//  Task.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation
import SwiftUI

struct Task: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let title: String
    let description: String?
    let status: String
    let dueDate: Date?
    let parentId: UUID?
    let createdAt: Date

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
    
    public static func decodeTask(from json: String) throws -> Task {
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Task.self, from: data)
    }
}

