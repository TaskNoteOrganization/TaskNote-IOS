//
//  SignupView.swift
//  TaskNoteIOS
//
//  Created by Daniel Martinez on 4/27/25.
//

import SwiftUI

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signupError: String?
    @State private var navigateToHome: Bool = false


    var body: some View {
        VStack(spacing: 20) {
            Text("Create an account")
                .font(.largeTitle)
                .bold()

            TextField("email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            SecureField("password", text: $password)
                .textContentType(.newPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            if let error = signupError {
                Text(error)
                    .foregroundColor(.red)
            }

            Button("Create Account") {
                
                async {
                    do {
                        try await SupabaseService.shared.signUp(email: email, password: password)
                        navigateToHome = true
                    } catch {
                        signupError = "\(error.localizedDescription)"
                    }
                    
                    
                }
                

                
            }
            .buttonStyle(.bordered)
            .foregroundColor(Color.white)
            .background(Color.purple)
            .cornerRadius(5)
            .padding()
            
            NavigationLink(
                destination: NoteListView(someNoteList: Note.mockNotes),
                isActive: $navigateToHome,
                label: {
                    EmptyView()
                })
        
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
