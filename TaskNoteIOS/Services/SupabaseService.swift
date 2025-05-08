//
//  SupabaseService.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//

import Foundation
import Supabase
import Combine



public final class SupabaseService : ObservableObject{
    public static let shared = SupabaseService()

        @Published var currentSession: Session? = nil

    // MARK: - Sign in / up / out
    
    
        public func signUp(email: String, password: String) async throws -> AuthResponse {
            let response = try await client.auth.signUp(email: email, password: password)
            self.currentSession = response.session
            return response
        }

    public func signIn(email: String, password: String) async throws -> Session {
        let session = try await client.auth.signIn(email: email, password: password)
        DispatchQueue.main.async {
            self.currentSession = session
        }
        return session
    }


        public func signOut() async throws {
            try await client.auth.signOut()
            DispatchQueue.main.async {
                self.currentSession = nil
            }
        }
    
    public func getCurrentUser() async throws -> User? {
        try await client.auth.session.user
    }
    
    // MARK: - Models
    
    public func fetchTasks() async throws -> [Task] {
        let response = try await client
            .from("tasks")
            .select()
            .execute()
        
        let data = response.data
        return try JSONDecoder.supabaseDecoder.decode([Task].self, from: data)
    }
    
    func fetchNotes() async throws -> [Note] {
        let response = try await client
            .from("notes")
            .select()
            .execute()
        
        let data = response.data
        return try JSONDecoder.supabaseDecoder.decode([Note].self, from: data)
    }
    
    func fetchReminders() async throws -> [Reminder] {
        let response = try await client
            .from("reminders_view")
            .select()
            .execute()
        
        let data = response.data
        return try JSONDecoder.supabaseDecoder.decode([Reminder].self, from: data)
    }
    
    func fetchUserID() async throws -> UUID {
        guard let user = try await getCurrentUser() else {
            fatalError("No user signed in")
        }
        
        return user.id
    }
    
    func fetchNoteTaskLinks() async throws -> [NoteTaskLink] {
        let response = try await client
            .from("note_task_links")
            .select()
            .execute()
        
        let data = response.data
        return try JSONDecoder.supabaseDecoder.decode([NoteTaskLink].self, from: data)
    }
    
    func fetchNoteTaskLinksFromNote(noteID: UUID) async throws -> [NoteTaskLink] {
        let response = try await client
            .from("note_task_links")
            .select()
            .eq("note_id", value: noteID.uuidString)
            .execute()
        
        let data = response.data
        return try JSONDecoder.supabaseDecoder.decode([NoteTaskLink].self, from: data)
    }
    
    func fetchRemindersFromTask(taskID: UUID) async throws -> [Reminder] {
        let response = try await client
            .from("reminders_view")
            .select()
            .eq("task_id", value: taskID.uuidString)
            .execute()
        
        let data = response.data
        return try JSONDecoder.supabaseDecoder.decode([Reminder].self, from: data)
    }
    
    public func createNote(title: String, path: String) async throws -> Note {
        let uid = try requireUserID()
        
        let newNote = try await client
            .from("notes")
            .insert([
                "user_id": uid,
                "title": title,
                "file_path": path
            ])
            .select()
            .single()
            .execute()
            .value as Note
        
        return newNote
    }
    
    public func createTask(title: String) async throws -> Task {
        let uid = try requireUserID()
        
        let newTask = try await client
            .from("tasks")
            .insert([
                "user_id": uid,
                "title": title
            ])
            .select()
            .single()
            .execute()
            .value as Task
        
        return newTask
    }
    
    public func createTaskLink(taskID: UUID, noteID: UUID) async throws -> NoteTaskLink {
        let newLink = try await client
            .from("note_task_links")
            .insert([
                "task_id": taskID,
                "note_id": noteID
            ])
            .select()
            .single()
            .execute()
            .value as NoteTaskLink
        return newLink
    }
    
    public func createReminder(taskID: UUID, time: Date) async throws -> Reminder {
        let formatter = ISO8601DateFormatter()
        
        let newReminder = try await client
            .from("reminders")
            .insert([
                "task_id": taskID.uuidString,
                "remind_at": formatter.string(from: time),
                "is_sent": "false"
            ])
            .select()
            .single()
            .execute()
            .value as Reminder
        
        return newReminder
    }
    
    
    // MARK: - Storage
    
    public func uploadMarkdownFile(data: Data, filename: String) async throws -> String {
        let uid = try requireUserID()
        let path = "\(uid)/\(filename)"
        _ = try await client
            .storage
            .from("tasknotes-notes")
            .upload(path, data: data)
        return path
    }
    
    /// Downloads a markdown note from Supabase Storage
    /// - Parameter path: The storage path to the markdown file (e.g., "tasknotes-notes/user-id/file.md")
    /// - Returns: The raw markdown data
    public func downloadMarkdownFile(path: String) async throws -> Data {
        try await client
            .storage
            .from("tasknotes-notes")
            .download(path: path)
    }
    
    public func debugPrintCurrentUser() {
        let uid = client.auth.currentUser?.id.uuidString ?? "nil"
        print("Current signed-in user ID: \(uid)")
    }
    
    
    // MARK: - OAuth Login
    public func signInWithOAuth(provider: Provider) async throws -> Session {
        let session = try await client.auth.signInWithOAuth(provider: provider)
        return session
    }
    
    // MARK: - Delete
    public func deleteNote(noteID: UUID) async throws {
        try await client
            .from("notes")
            .delete()
            .eq("id", value: noteID.uuidString)
            .execute()
    }

    public func deleteTask(taskID: UUID) async throws {
        try await client
            .from("tasks")
            .delete()
            .eq("id", value: taskID.uuidString)
            .execute()
    }

    public func deleteTaskLink(noteID: UUID, taskID: UUID) async throws {
        try await client
            .from("note_task_links")
            .delete()
            .eq("note_id", value: noteID.uuidString)
            .eq("task_id", value: taskID.uuidString)
            .execute()
    }


    
    
    private init() {}
    private let supabaseUrl = URL(string: "https://fzlwnrnfreklyainlfpy.supabase.co")!
    private let supabaseAnonKey =  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6bHducm5mcmVrbHlhaW5sZnB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ1OTU4MzIsImV4cCI6MjA2MDE3MTgzMn0.rmNN79iPkLLFpOV4p2hS1Opl5EXAo9adT0kpc1R_PJo"
    
    private lazy var client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseAnonKey)
    
    private func requireUserID() throws -> String {
        guard let uid = client.auth.currentUser?.id.uuidString else {
            throw NSError(domain: "SupabaseService", code: 401, userInfo: [
                NSLocalizedDescriptionKey: "User not authenticated"
            ])
        }
        return uid
    }
    
    
}

extension JSONDecoder {
    static let supabaseDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            if let date = isoFormatter.date(from: dateStr) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Expected ISO8601 date with fractional seconds: \(dateStr)"
                )
            }
        }
        return decoder
    }()
}

