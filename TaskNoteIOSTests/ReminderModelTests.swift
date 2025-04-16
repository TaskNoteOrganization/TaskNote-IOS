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
    
    private var formatter: DateFormatter {
        DateFormatter.supabaseFixedMicrosecondFormatter
    }
    
    @Test("Valid reminder decoding")
    func validReminderTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "task_id": "\(UUID())",
            "remind_at": "\(formatter.string(from: Date().addingTimeInterval(3600)))",
            "is_sent": false
        }
        """
        let data = json.data(using: .utf8)!
        let reminder = try JSONDecoder.supabaseDecoder.decode(Reminder.self, from: data)
        #expect(reminder.isSent == false)
    }
    
    @Test("Missing taskId should fail")
    func missingTaskIdTest() {
        let json = """
        {
            "id": "\(UUID())",
            "remind_at": "\(formatter.string(from: Date()))",
            "is_sent": false
        }
        """
        let data = json.data(using: .utf8)!
        do {
            _ = try JSONDecoder.supabaseDecoder.decode(Reminder.self, from: data)
            #expect(Bool(false), "Expected decoding to fail for missing task_id")
        } catch {
            #expect(true)
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
        let data = json.data(using: .utf8)!
        do {
            _ = try JSONDecoder.supabaseDecoder.decode(Reminder.self, from: data)
            #expect(Bool(false), "Expected decoding to fail for missing remind_at")
        } catch {
            #expect(true)
        }
    }
    
    @Test("Missing isSent should fail")
    func missingIsSentTest() {
        let json = """
        {
            "id": "\(UUID())",
            "task_id": "\(UUID())",
            "remind_at": "\(formatter.string(from: Date()))"
        }
        """
        let data = json.data(using: .utf8)!
        do {
            _ = try JSONDecoder.supabaseDecoder.decode(Reminder.self, from: data)
            #expect(Bool(false), "Expected decoding to fail for missing is_sent")
        } catch {
            #expect(true)
        }
    }
}
