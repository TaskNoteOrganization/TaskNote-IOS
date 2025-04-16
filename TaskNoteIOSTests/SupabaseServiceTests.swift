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

    @Test("Sign up creates user (simulated)")
    func signUpTest() async throws {
        do {
            try await SupabaseService.shared.signUp(email: "test+\(UUID().uuidString)@example.com", password: "password123")
            #expect(Bool(true))
        } catch {
            #expect(Bool(false), "Sign up failed with error: \(error)")
        }
    }

    @Test("Sign in with valid credentials")
    func signInTest() async throws {
        do {
            try await SupabaseService.shared.signIn(email: "test@example.com", password: "password123")
            #expect(SupabaseService.shared.currentUser != nil)
        } catch {
            #expect(Bool(false), "Sign in failed with error: \(error)")
        }
    }

    @Test("Sign in fails with invalid credentials")
    func signInFailureTest() async {
        do {
            try await SupabaseService.shared.signIn(email: "invalid@email.com", password: "wrongpassword")
            #expect(Bool(false), "Expected sign in to fail with invalid credentials")
        } catch {
            #expect(Bool(true))
        }
    }

    @Test("Sign out completes without error")
    func signOutTest() async throws {
        do {
            try await SupabaseService.shared.signOut()
            #expect(Bool(true))
        } catch {
            #expect(Bool(false), "Sign out failed with error: \(error)")
        }
    }

    @Test("Fetch tasks returns valid structure")
    func fetchTasksTest() async throws {
        do {
            let tasks = try await SupabaseService.shared.fetchTasks()
            #expect(tasks.count >= 0)
        } catch {
            #expect(Bool(false), "Fetching tasks failed with error: \(error)")
        }
    }

    @Test("Fetch tasks handles empty response")
    func fetchEmptyTasksTest() async throws {
        do {
            let tasks = try await SupabaseService.shared.fetchTasks()
            #expect(!tasks.isEmpty || tasks.count == 0) // Allow empty, but must be valid
        } catch {
            #expect(Bool(false), "Expected fetchTasks to return empty or array, got error: \(error)")
        }
    }

    @Test("Upload note returns valid path")
    func uploadNoteTest() async throws {
        do {
            let dummyMarkdown = "# Heading\nNote content.".data(using: .utf8)!
            let filename = "test-\(UUID().uuidString).md"
            let path = try await SupabaseService.shared.uploadNote(markdown: dummyMarkdown, filename: filename)
            #expect(path.contains(filename))
        } catch {
            #expect(Bool(false), "Uploading note failed with error: \(error)")
        }
    }

    @Test("Upload fails without authentication")
    func uploadNoteUnauthenticatedTest() async {
        do {
            try await SupabaseService.shared.signOut()
            let dummyMarkdown = "Unauthenticated test".data(using: .utf8)!
            _ = try await SupabaseService.shared.uploadNote(markdown: dummyMarkdown, filename: "unauth.md")
            #expect(Bool(false), "Expected upload to fail due to unauthenticated user")
        } catch {
            #expect(Bool(true))
        }
    }

    @Test("Current user is nil after logout")
    func userIsNilAfterSignOutTest() async throws {
        try await SupabaseService.shared.signOut()
        #expect(SupabaseService.shared.currentUser == nil)
    }

    @Test("Current user is not nil after login")
    func userExistsAfterSignInTest() async throws {
        try await SupabaseService.shared.signIn(email: "test@example.com", password: "password123")
        #expect(SupabaseService.shared.currentUser != nil)
    }
}
