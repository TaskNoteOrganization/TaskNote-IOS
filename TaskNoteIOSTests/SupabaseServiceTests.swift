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
    
    @Test("Supabase Service - invalid Sign in Test")
    func invalidSignInTest() async throws {
        do {
            _ = try await SupabaseService.shared.signIn(email: "invalid@example.com", password: "wrongpass")
            #expect(Bool(false), "Expected invalid sign-in to fail")
        } catch {
            #expect(true)
        }
    }
    
    @Test("Supabase Service - valid Sign in Test")
    func validSignInTest() async throws {
        let session = try await SupabaseService.shared.signIn(email: "abetancourt@csumb.edu", password: "password123")
        #expect(session.user != nil)
    }
    
    @Test("Supabase Service - get current user test")
    func getCurrentUserTest() async throws {
        _ = try await SupabaseService.shared.signIn(email: "abetancourt@csumb.edu", password: "password123")
        let user = try await SupabaseService.shared.getCurrentUser()
        #expect(user != nil)
    }
    
    @Test("Supabase Service - fetch note test")
    func fetchNoteTest() async throws {
        let notes = try await SupabaseService.shared.fetchNotes()
        #expect(notes.count >= 0)
    }
    
    @Test("Supabase Service - fetch task test")
    func fetchTaskTest() async throws {
        let tasks = try await SupabaseService.shared.fetchTasks()
        #expect(tasks.count >= 0)
    }
    
    @Test("Supabase Service - Store note Test")
    func storeNoteTest() async throws {
        _ = try await SupabaseService.shared.signIn(email: "abetancourt@csumb.edu", password: "password123")
        
        let user = try await SupabaseService.shared.getCurrentUser()
        guard let uid = user?.id.uuidString else {
            throw NSError(domain: "Test", code: 401, userInfo: [NSLocalizedDescriptionKey: "User ID missing"])
        }
        SupabaseService.shared.debugPrintCurrentUser()
        
        
        let data = "# Hello World".data(using: .utf8)!
        let filename = "test-\(UUID().uuidString).md"
        let path = "\(filename)"  // ✅ manually build correct path
        print(path)
        
        _ = try await SupabaseService.shared.uploadMarkdownFile(data: data, filename: path)
        #expect(path.contains(filename))
    }
    
    
    @Test("Supabase Service - Get note Test")
    func getNoteTest() async throws {
        _ = try await SupabaseService.shared.signIn(email: "abetancourt@csumb.edu", password: "password123")
        
        let markdown = "# Test Note".data(using: .utf8)!
        let filename = "gettest-\(UUID().uuidString).md"
        let path = try await SupabaseService.shared.uploadMarkdownFile(data: markdown, filename: filename)
        
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
        _ = try await SupabaseService.shared.signIn(email: "abetancourt@csumb.edu", password: "password123")
        
        let user = try await SupabaseService.shared.getCurrentUser()
        guard let uid = user?.id.uuidString else {
            throw NSError(domain: "Test", code: 401, userInfo: [NSLocalizedDescriptionKey: "User ID missing"])
        }
        
        let fileData = "# All Round".data(using: .utf8)!
        let time = Date().timeIntervalSince1970
        let filename = "allround\(time).md"
        let fullPath = "\(uid)/allround\(time).md"
        
        _ = try await SupabaseService.shared.uploadMarkdownFile(data: fileData, filename: filename)
        
        let fetched = try await SupabaseService.shared.downloadMarkdownFile(path: fullPath)
        
        let taskCount = try await SupabaseService.shared.fetchTasks().count
        let noteCount = try await SupabaseService.shared.fetchNotes().count
        
        try await SupabaseService.shared.signOut()
        
        #expect(taskCount >= 0)
        #expect(noteCount >= 0)
        #expect(String(data: fetched, encoding: .utf8) == "# All Round")
    }
    
    
}
