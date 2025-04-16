//
//  Note.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let title: String?
    let filePath: String
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case filePath = "file_path"
        case createdAt = "created_at"
    }
}

