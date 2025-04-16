//
//  ReminderModelTests.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation
import Testing
@testable import TaskNoteIOS

@Suite("Reminder Model Tests")
struct ReminderTests {
    
    @Test("Valid reminder decoding")
    func validReminderTest() throws {
        let iso = ISO8601DateFormatter()
        let json = """
        {
            "id": "\(UUID())",
            "task_id": "\(UUID())",
            "remind_at": "\(iso.string(from: Date().addingTimeInterval(3600)))",
            "is_sent": false
        }
        """
        let reminder = try decodeReminder(from: json)
        #expect(reminder.isSent == false)
    }
    
    @Test("Missing taskId should fail")
    func missingTaskIdTest() {
        let iso = ISO8601DateFormatter()
        let json = """
        {
            "id": "\(UUID())",
            "remind_at": "\(iso.string(from: Date()))",
            "is_sent": false
        }
        """
        do {
            _ = try decodeReminder(from: json)
            #expect(Bool(false), "Expected decoding to fail for missing task_id")
        } catch {
            #expect(Bool(true))
        }
    }

    @Test("Missing remindAt should fail")
    func missingRemindAtTest() {
        let json = """
        {
            "id": "\(UUID())",
            "task_id": "\(UUID())",
            "is_sent": false
        }
        """
        do {
            _ = try decodeReminder(from: json)
            #expect(Bool(false), "Expected decoding to fail for missing remind_at")
        } catch {
            #expect(Bool(true))
        }
    }

    @Test("Missing isSent should fail")
    func missingIsSentTest() {
        let iso = ISO8601DateFormatter()
        let json = """
        {
            "id": "\(UUID())",
            "task_id": "\(UUID())",
            "remind_at": "\(iso.string(from: Date()))"
        }
        """
        do {
            _ = try decodeReminder(from: json)
            #expect(Bool(false), "Expected decoding to fail for missing is_sent")
        } catch {
            #expect(Bool(true))
        }
    }
    
    // JSON decoding helper
    private func decodeReminder(from json: String) throws -> Reminder {
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Reminder.self, from: data)
    }
}
