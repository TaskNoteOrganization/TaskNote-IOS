//
//  SupabaseService.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import Foundation
import Supabase
import Observation

/// A singleton service for managing Supabase interaction:
/// - Authentication (sign up, login, logout)
/// - Database operations (e.g., tasks)
/// - File storage (e.g., markdown notes)
@Observable
final class SupabaseService {
    
    /// Shared global instance for use throughout the app
    public static let shared = SupabaseService()
    
    /// The main Supabase client, configured at init
    public let client: SupabaseClient

    /// Currently authenticated user, if any
    public var currentUser: User? {
        client.auth.currentUser
    }
    
    /// Registers a new user using email and password
    public func signUp(email: String, password: String) async throws {
        _ = try await client.auth.signUp(email: email, password: password)
    }

    /// Signs in an existing user using email and password
    public func signIn(email: String, password: String) async throws {
        _ = try await client.auth.signIn(email: email, password: password)
    }

    /// Logs out the current user
    public func signOut() async throws {
        try await client.auth.signOut()
    }

    /// Fetches all tasks associated with the current user
    public func fetchTasks() async throws -> [Task] {
        try await client
            .from("tasks")
            .select()
            .execute()
            .value
    }

    /// Uploads a markdown note to Supabase Storage under the current user's folder
    /// - Parameters:
    ///   - markdown: The content of the note as Data
    ///   - filename: The desired filename (e.g. "idea.md")
    /// - Returns: The full storage path used
    public func uploadNote(markdown: Data, filename: String) async throws -> String {
        let userID = try requireUserID()
        let path = "tasknotes-notes/\(userID)/\(filename)"
        _ = try await client
            .storage
            .from("tasknotes-notes")
            .upload(path, data: markdown)
        return path
    }

    /// Your Supabase project URL (found in Supabase dashboard)
    private let supabaseURL = URL(string: "https://your-project-id.supabase.co")!

    /// Your Supabase anon public API key
    private let supabaseAnonKey = "your-anon-key"

    /// Private initializer to enforce singleton usage
    private init() {
        self.client = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseAnonKey
        )
    }

    /// Helper to get the current user ID or throw an auth error
    private func requireUserID() throws -> String {
        guard let uid = client.auth.currentUser?.id.uuidString else {
            throw NSError(
                domain: "SupabaseService",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]
            )
        }
        return uid
    }
}
