//
//  SupabaseService.swift
//  TaskNoteIOS
//
//  Created by Alexander Betancourt on 4/15/25.
//
import Foundation
import Supabase

public final class SupabaseService {
    public static let shared = SupabaseService()
    
    // MARK: - Sign in / up / out
    
    public func signUp(email: String, password: String) async throws -> AuthResponse {
        try await client.auth.signUp(email: email, password: password)
    }
    
    public func signIn(email: String, password: String) async throws -> Session {
        try await client.auth.signIn(email: email, password: password)
    }
    
    public func signOut() async throws -> Void {
        try await client.auth.signOut()
    }
    
    public func getCurrentUser() async throws -> User? {
        try await client.auth.session.user
    }
    
    // MARK: - Models
    
    public func fetchTasks() async throws -> [Task] {
        try await client
            .from("tasks")
            .select()
            .execute()
            .value
    }
    
    func fetchNotes() async throws -> [Note] {
        let response = try await client
            .from("notes")
            .select()
            .execute()
        
        let data = response.data
        return try JSONDecoder.supabaseDecoder.decode([Note].self, from: data)
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
        print("👤 Current signed-in user ID: \(uid)")
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
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            
            let formats: [DateFormatter] = [
                .supabaseVariableSubsecondFormatter,
                .supabaseFixedMicrosecondFormatter
            ]
            
            for formatter in formats {
                if let date = formatter.date(from: dateStr) {
                    return date
                }
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid Supabase ISO8601 date: \(dateStr)")
        }
        return decoder
    }()
}


extension DateFormatter {
    /// Strict formatter for Supabase (fixed 6-digit microseconds + timezone)
    static let supabaseFixedMicrosecondFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
        f.timeZone = TimeZone(secondsFromGMT: 0)
        return f
    }()
    
    /// More tolerant formatter for Supabase (handles variable subseconds)
    static let supabaseVariableSubsecondFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX" // handles 3–6 digit fractions
        f.timeZone = TimeZone(secondsFromGMT: 0)
        return f
    }()
}

