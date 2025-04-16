//
//  TaskNoteIOSTests.swift
//  TaskNoteIOSTests
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Testing
import Foundation
@testable import TaskNoteIOS

@Suite("Task Model Tests") struct TaskModelTests {
    @Test("Task Initialization")
    func taskInitalizationTest() throws {
        let json = """
                {
                    "id": "\(UUID())",
                    "user_id": "\(UUID())",
                    "title": "Sample Task",
                    "status": "pending",
                    "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
                }
                """
        let task = try Task.decodeTask(from: json)
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
                    "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
                }
                """
        let task = try Task.decodeTask(from: json)
        #expect(task.description == "Detailed task here")
    }
    
    @Test("Task due date")
    func taskDueDateTest() throws {
        let dueDate = ISO8601DateFormatter().string(from: Date().addingTimeInterval(86400))
        let json = """
                {
                    "id": "\(UUID())",
                    "user_id": "\(UUID())",
                    "title": "Due Task",
                    "status": "pending",
                    "due_date": "\(dueDate)",
                    "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
                }
                """
        let task = try Task.decodeTask(from: json)
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
                    "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
                }
                """
        let task = try Task.decodeTask(from: json)
        #expect(task.parentId == parentId)
    }
    
    @Test("Task null description")
    func taskNullDescriptionTest() throws {
        let json = """
            {
                "id": "\(UUID())",
                "user_id": "\(UUID())",
                "title": "Null Desc",
                "description": null,
                "status": "pending",
                "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
            }
            """
        let task = try Task.decodeTask(from: json)
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
                "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
            }
            """
        let task = try Task.decodeTask(from: json)
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
                "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
            }
            """
        let task = try Task.decodeTask(from: json)
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
                "created_at": "\(ISO8601DateFormatter().string(from: Date()))"
            }
            """
        let task = try Task.decodeTask(from: json)
        #expect(task.description == nil)
        #expect(task.dueDate == nil)
        #expect(task.parentId == nil)
    }
    
    
    @Test("Task all around")
    func taskAllRoundTest() throws {
        let id = UUID()
        let userId = UUID()
        let parentId = UUID()
        let dueDate = ISO8601DateFormatter().string(from: Date().addingTimeInterval(7200))
        let createdAt = ISO8601DateFormatter().string(from: Date())
        
        let json = """
                {
                    "id": "\(id)",
                    "user_id": "\(userId)",
                    "title": "Full Feature Task",
                    "description": "Covers everything",
                    "status": "completed",
                    "due_date": "\(dueDate)",
                    "parent_id": "\(parentId)",
                    "created_at": "\(createdAt)"
                }
                """
        let task = try Task.decodeTask(from: json)
        #expect(task.id == id)
        #expect(task.userId == userId)
        #expect(task.title == "Full Feature Task")
        #expect(task.description == "Covers everything")
        #expect(task.status == "completed")
        #expect(task.parentId == parentId)
        #expect(task.dueDate != nil)
    }
}

