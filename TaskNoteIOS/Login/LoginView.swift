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
                    .frame(width: 300)
                
                SecureField("password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(width: 300)

                
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
                .buttonStyle(.bordered)
                .foregroundColor(Color.white)
                .background(Color.purple)
                .cornerRadius(5)
                .padding()


                
                Spacer()
                
                Button("Don't have an account? Sign up") {
                    showSignup = true
                    
                }
                .padding(.top, 8)
                .foregroundColor(Color.purple)
                
                NavigationLink("", destination: SignupView(), isActive: $showSignup)
                    .hidden()
                
                NavigationLink(
                    destination: NoteListView(someNoteList: Note.mockNotes),
                    isActive: $navigateToHome,
                    label: {
                        EmptyView()
                    })
                .padding()
            }
        }
    }
    
    #Preview {
        NoteListView(someNoteList: Note.mockNotes)
            .environmentObject(ColorSettings(previewing : true))
    }
}
