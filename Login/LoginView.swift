//
//  LoginView.swift
//  TaskNoteIOS
//
//  Created by Daniel Martinez on 4/27/25.
//


import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginError: String?
    @State private var navigateToHome: Bool = false
    @State private var showSignup: Bool = false


    var body: some View {
        NavigationStack {
            
            VStack(spacing: 20) {
                Spacer()
                Text("TaskNote")
                    .font(.largeTitle)
                    .bold()

                TextField("email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                SecureField("password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                if let error = loginError {
                    Text(error)
                        .foregroundColor(.red)
                }

                Button("Login") {
                    async {
                        do {
                            try await SupabaseService.shared.signIn(email: email, password: password)
                            navigateToHome = true
                        } catch {
                            loginError = "\(error.localizedDescription)"
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()

                Button("Don't have an account? Sign up") {
                    showSignup = true

                }
                .padding(.top, 8)

                NavigationLink("", destination: NoteListView(), isActive: $navigateToHome)
                    .hidden()
                NavigationLink("", destination: SignupView(), isActive: $showSignup)
                    .hidden()
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
