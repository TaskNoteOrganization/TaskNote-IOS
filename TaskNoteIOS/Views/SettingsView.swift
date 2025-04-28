//
//  SettingsView.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/17/25.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var darkMode : ColorSettings
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                VStack {
                    
                    TopMiniBar(someTitle: "Settings")
                    
                    VStack {
                        
                        Spacer()
                        
                        HStack {
                            
                            Button(action: tempFunc) {
                                Label("Log out", systemImage: "arrow.up").font(.title2)
                            }
                            .buttonStyle(.bordered)
                            .background(Color.bg2)
                            .foregroundStyle(Color.main)
                            
                            Spacer()
                        }
                        
                        HStack {
                            
                            Button(action: tempFunc) {
                                Label("Change Password", systemImage: "arrow.up").font(.title2)
                            }
                            .buttonStyle(.bordered)
                            .background(Color.bg2)
                            .foregroundStyle(Color.main)
                            
                            Spacer()
                        }
                        
                        HStack {
                            
                            Button(action: tempFunc) {
                                Label("Change Username", systemImage: "arrow.up").font(.title2)
                            }
                            .buttonStyle(.bordered)
                            .background(Color.bg2)
                            .foregroundStyle(Color.main)
                            
                            Spacer()
                        }
                        
                        HStack {
                            
                            Button(action: tempFunc) {
                                Label("Change Email", systemImage: "arrow.up").font(.title2)
                            }
                            .buttonStyle(.bordered)
                            .background(Color.bg2)
                            .foregroundStyle(Color.main)
                            
                            Spacer()
                        }
                        
                        Toggle("Dark Mode", isOn: $darkMode.darkMode).font(.title2)
                        
                        Spacer()
                        
                        HStack {
                            
                            Button(action: tempFunc) {
                                Label("Delete Account", systemImage: "arrow.up").font(.title2)
                            }
                            .buttonStyle(.bordered).tint(Color.main)
                            
                            Spacer()
                        }
                        
                        Spacer()
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                
                // Spacer()
                
                HomeNavBar()
            }
            .padding()
            .background(Color.bg3)
            
        }.navigationBarBackButtonHidden(true)
            .preferredColorScheme(darkMode.darkMode ? .dark : .light)
            .environmentObject(ColorSettings())
        
    }
}

func tempFunc() {
    
}

#Preview {
    SettingsView()
}
