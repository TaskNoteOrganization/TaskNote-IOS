//
//  TaskModelTests.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import Foundation
import Testing
@testable import TaskNoteIOS

@Suite("Task Model Tests")
struct TaskModelTests {
    
    private var formatter: DateFormatter {
        DateFormatter.supabaseFixedMicrosecondFormatter
    }
    
    private func iso(_ date: Date = Date()) -> String {
        formatter.string(from: date)
    }
    
    @Test("Task Initialization")
    func taskInitializationTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "Sample Task",
            "status": "pending",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.title == "Sample Task")
        #expect(task.status == "pending")
    }
    
    @Test("Task description")
    func taskDescriptionTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "Description Task",
            "description": "Detailed task here",
            "status": "in_progress",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.description == "Detailed task here")
    }
    
    @Test("Task due date")
    func taskDueDateTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "Due Task",
            "status": "pending",
            "due_date": "\(iso(Date().addingTimeInterval(86400)))",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.dueDate != nil)
    }
    
    @Test("Task parent ID")
    func taskParentIDTest() throws {
        let parentId = UUID()
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "Child Task",
            "parent_id": "\(parentId)",
            "status": "pending",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.parentId == parentId)
    }
    
    @Test("Task null description")
    func taskNullDescriptionTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "No Desc",
            "description": null,
            "status": "pending",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.description == nil)
    }
    
    @Test("Task null due date")
    func taskNullDueDateTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "No Due Date",
            "due_date": null,
            "status": "in_progress",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.dueDate == nil)
    }
    
    @Test("Task null parent ID")
    func taskNullParentIDTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "Top-level Task",
            "parent_id": null,
            "status": "pending",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.parentId == nil)
    }
    
    @Test("Task missing optional fields entirely")
    func taskMissingOptionalFieldsTest() throws {
        let json = """
        {
            "id": "\(UUID())",
            "user_id": "\(UUID())",
            "title": "Minimal Task",
            "status": "pending",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.description == nil)
        #expect(task.dueDate == nil)
        #expect(task.parentId == nil)
    }
    
    @Test("Task all around")
    func taskAllRoundTest() throws {
        let id = UUID()
        let userId = UUID()
        let parentId = UUID()
        let json = """
        {
            "id": "\(id)",
            "user_id": "\(userId)",
            "title": "Full Feature Task",
            "description": "Covers everything",
            "status": "completed",
            "due_date": "\(iso(Date().addingTimeInterval(7200)))",
            "parent_id": "\(parentId)",
            "created_at": "\(iso())"
        }
        """
        let task = try JSONDecoder.supabaseDecoder.decode(Task.self, from: json.data(using: .utf8)!)
        #expect(task.id == id)
        #expect(task.userId == userId)
        #expect(task.title == "Full Feature Task")
        #expect(task.description == "Covers everything")
        #expect(task.status == "completed")
        #expect(task.parentId == parentId)
        #expect(task.dueDate != nil)
    }
}
