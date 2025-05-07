//
//  SupabaseServiceTests.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import Foundation
import Testing
@testable import TaskNoteIOS

@Suite("Supabase Service Tests")
struct SupabaseServiceTests {
    
    private let email = "abetancourt@csumb.edu"
    private let password = "password123"

    private func signInIfNeeded() async throws {
        _ = try await SupabaseService.shared.signIn(email: email, password: password)
    }
    
    private func randomMarkdownData(title: String = "Hello World") -> (data: Data, filename: String) {
        let data = "# \(title)".data(using: .utf8)!
        let filename = "test-\(UUID()).md"
        return (data, filename)
    }
    
    @Test("Supabase Service - invalid Sign in Test")
    func invalidSignInTest() async throws {
        do {
            _ = try await SupabaseService.shared.signIn(email: "invalid@example.com", password: "wrongpass")
            #expect(Bool(false), "Expected invalid sign-in to fail")
        } catch {
            #expect(true)
        }https://fzlwnrnfreklyainlfpy.supabase.co/
    }
    
    @Test("Supabase Service - valid Sign in Test")
    func validSignInTest() async throws {
        let session = try await SupabaseService.shared.signIn(email: email, password: password)
        #expect(session.user != nil)
    }
    
    @Test("Supabase Service - get current user test")
    func getCurrentUserTest() async throws {
        try await signInIfNeeded()
        let user = try await SupabaseService.shared.getCurrentUser()
        #expect(user != nil)
    }
    
    @Test("Supabase Service - fetch note test")
    func fetchNoteTest() async throws {
        try await signInIfNeeded()
        let notes = try await SupabaseService.shared.fetchNotes()
        #expect(notes.count >= 0)
    }
    
    @Test("Supabase Service - fetch task test")
    func fetchTaskTest() async throws {
        try await signInIfNeeded()
        let tasks = try await SupabaseService.shared.fetchTasks()
        #expect(tasks.count >= 0)
    }
    
    @Test("Supabase Service - Store note Test")
    func storeNoteTest() async throws {
        try await signInIfNeeded()
        let (data, filename) = randomMarkdownData()
        let path = try await SupabaseService.shared.uploadMarkdownFile(data: data, filename: filename)
        #expect(path.contains(filename))
    }
    
    @Test("Supabase Service - Get note Test")
    func getNoteTest() async throws {
        try await signInIfNeeded()
        let (data, filename) = randomMarkdownData(title: "Test Note")
        let path = try await SupabaseService.shared.uploadMarkdownFile(data: data, filename: filename)
        _ = try await SupabaseService.shared.createNote(title: "Test Note", path: path)
        
        let notes = try await SupabaseService.shared.fetchNotes()
        #expect(notes.contains { $0.filePath == path })
    }
    
    @Test("Supabase Service - Sign out Test")
    func validSignOutTest() async throws {
        try await SupabaseService.shared.signOut()
        let user = try? await SupabaseService.shared.getCurrentUser()
        #expect(user == nil)
    }
    
    @Test("Supabase Service - All round Test")
    func allRoundTest() async throws {
        try await signInIfNeeded()
        let user = try await SupabaseService.shared.getCurrentUser()
        let uid = user!.id.uuidString
        
        let (fileData, filename) = randomMarkdownData(title: "All Round")
        let path = "\(uid)/\(filename)"
        
        _ = try await SupabaseService.shared.uploadMarkdownFile(data: fileData, filename: filename)
        let fetched = try await SupabaseService.shared.downloadMarkdownFile(path: path)
        
        let taskCount = try await SupabaseService.shared.fetchTasks().count
        let noteCount = try await SupabaseService.shared.fetchNotes().count
        
        try await SupabaseService.shared.signOut()
        
        #expect(taskCount >= 0)
        #expect(noteCount >= 0)
        #expect(String(data: fetched, encoding: .utf8)?.contains("All Round") == true)
    }
    
    @Test("Supabase Service - Create Task Test")
    func createTaskTest() async throws {
        try await signInIfNeeded()
        let task = try await SupabaseService.shared.createTask(title: "UnitTest Task")
        #expect(task.title == "UnitTest Task")
    }
    
    @Test("Supabase Service - Create Note Test")
    func createNoteTest() async throws {
        try await signInIfNeeded()
        let (fileData, filename) = randomMarkdownData(title: "Unit Test Note")
        let path = try await SupabaseService.shared.uploadMarkdownFile(data: fileData, filename: filename)
        let note = try await SupabaseService.shared.createNote(title: "UnitTest Note", path: path)
        
        #expect(note.title == "UnitTest Note")
        #expect(note.filePath.contains(filename))
    }
    
    @Test("Supabase Service - Create Note Task Link Test")
    func createNoteTaskLinkTest() async throws {
        try await signInIfNeeded()
        let task = try await SupabaseService.shared.createTask(title: "Link Task")
        let (fileData, filename) = randomMarkdownData(title: "Link Test")
        let path = try await SupabaseService.shared.uploadMarkdownFile(data: fileData, filename: filename)
        let note = try await SupabaseService.shared.createNote(title: "Link Note", path: path)
        
        let link = try await SupabaseService.shared.createTaskLink(taskID: task.id, noteID: note.id)
        #expect(link.noteId == note.id)
        #expect(link.taskId == task.id)
    }
    
    @Test("Supabase Service - Create Reminder Test")
    func createReminderTest() async throws {
        try await signInIfNeeded()
        let task = try await SupabaseService.shared.createTask(title: "Reminder Task")
        let reminderTime = Date().addingTimeInterval(3600)
        
        let reminder = try await SupabaseService.shared.createReminder(taskID: task.id, time: reminderTime)
        
        #expect(reminder.taskId == task.id)
        #expect(Calendar.current.isDate(reminder.remindAt, equalTo: reminderTime, toGranularity: .minute))
    }
    
    @Test("Supabase Service - Fetch Reminders Test")
    func fetchRemindersTest() async throws {
        try await signInIfNeeded()
        let reminders = try await SupabaseService.shared.fetchReminders()
        #expect(reminders.count >= 0)
    }
    
    @Test("Supabase Service - Fetch User ID Test")
    func fetchUserIDTest() async throws {
        try await signInIfNeeded()
        let userID = try await SupabaseService.shared.fetchUserID()
        #expect(!userID.uuidString.isEmpty)
    }
    
    @Test("Supabase Service - Fetch Note Task Links Test")
    func fetchNoteTaskLinksTest() async throws {
        try await signInIfNeeded()
        let links = try await SupabaseService.shared.fetchNoteTaskLinks()
        #expect(links.count >= 0)
    }
    
    @Test("Supabase Service - Fetch Note Task Links From Note Test")
    func fetchNoteTaskLinksFromNoteTest() async throws {
        try await signInIfNeeded()
        
        // Create a task and note first
        let task = try await SupabaseService.shared.createTask(title: "LinkFromNote Task")
        let (fileData, filename) = randomMarkdownData(title: "LinkFromNote Test")
        let path = try await SupabaseService.shared.uploadMarkdownFile(data: fileData, filename: filename)
        let note = try await SupabaseService.shared.createNote(title: "LinkFromNote Note", path: path)
        
        _ = try await SupabaseService.shared.createTaskLink(taskID: task.id, noteID: note.id)
        
        let links = try await SupabaseService.shared.fetchNoteTaskLinksFromNote(noteID: note.id)
        #expect(links.contains { $0.noteId == note.id })
    }
    
    @Test("Supabase Service - Fetch Reminders From Task Test")
    func fetchRemindersFromTaskTest() async throws {
        try await signInIfNeeded()
        
        // Create a task and reminder first
        let task = try await SupabaseService.shared.createTask(title: "ReminderFromTask Task")
        let reminderTime = Date().addingTimeInterval(3600)
        _ = try await SupabaseService.shared.createReminder(taskID: task.id, time: reminderTime)
        
        let reminders = try await SupabaseService.shared.fetchRemindersFromTask(taskID: task.id)
        #expect(reminders.contains { $0.taskId == task.id })
    }
    @Test("Supabase Service - All round test 2")
    func fullIntegrationTest() async throws {
        try await signInIfNeeded()
        
        // Step 1: Create a new Task
        let task = try await SupabaseService.shared.createTask(title: "Integration Task")
        #expect(task.title == "Integration Task")
        
        // Step 2: Create a Reminder for that Task
        let reminderTime = Date().addingTimeInterval(1800) // 30 minutes later
        let reminder = try await SupabaseService.shared.createReminder(taskID: task.id, time: reminderTime)
        #expect(reminder.taskId == task.id)
        
        // Step 3: Upload a markdown note
        let (fileData, filename) = randomMarkdownData(title: "Integration Note")
        let path = try await SupabaseService.shared.uploadMarkdownFile(data: fileData, filename: filename)
        
        // Step 4: Create a Note
        let note = try await SupabaseService.shared.createNote(title: "Integration Note", path: path)
        #expect(note.title == "Integration Note")
        
        // Step 5: Link the Note to the Task
        let link = try await SupabaseService.shared.createTaskLink(taskID: task.id, noteID: note.id)
        #expect(link.taskId == task.id)
        #expect(link.noteId == note.id)
        
        // Step 6: Fetch all reminders
        let reminders = try await SupabaseService.shared.fetchReminders()
        #expect(reminders.contains { $0.id == reminder.id })
        
        // Step 7: Fetch all notes
        let notes = try await SupabaseService.shared.fetchNotes()
        #expect(notes.contains { $0.id == note.id })
        
        // Step 8: Fetch all tasks
        let tasks = try await SupabaseService.shared.fetchTasks()
        #expect(tasks.contains { $0.id == task.id })
        
        // Step 9: Fetch NoteTaskLinks and validate
        let noteLinks = try await SupabaseService.shared.fetchNoteTaskLinks()
        #expect(noteLinks.contains { $0.noteId == note.id && $0.taskId == task.id })
        
        // Step 10: Download the markdown file and verify content
        let downloaded = try await SupabaseService.shared.downloadMarkdownFile(path: note.filePath)
        let markdown = String(data: downloaded, encoding: .utf8)
        #expect(markdown?.contains("Integration Note") == true)
    }

}
