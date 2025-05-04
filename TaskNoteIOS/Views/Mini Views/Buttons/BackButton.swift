//
//  BackButton.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 5/4/25.
//

import SwiftUI

struct BackButton: View {
    
    @EnvironmentObject var colorMode: ColorSettings
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerSize: CGSize.init(width: 30.0, height: 30.0)).foregroundStyle(Color.bg2)
            
            Text("Back").foregroundStyle(Color.main).fontWeight(.bold).font(.title3)
            
        }.frame(height: UIScreen.main.bounds.height * 0.05)
            .preferredColorScheme(colorMode.darkMode ? .dark : .light)
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
        
    }
}

#Preview {
    BackButton()
        .environmentObject(ColorSettings(previewing : true))
}
