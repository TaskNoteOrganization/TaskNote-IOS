//
//  TopMiniBar.swift
//  TaskNoteIOS
//
//  Created by Edward Leon on 4/20/25.
//

import SwiftUI

struct TopMiniBar: View {
    
    var someTitle : String
    
    var body: some View {
        
        ZStack {
            Rectangle().foregroundStyle(Color.gray)
            
            Text(someTitle).foregroundStyle(Color.white).fontWeight(.bold).font(.title)
            
        }.frame(height: UIScreen.main.bounds.height * 0.08)
        
    }
}

#Preview {
    TopMiniBar(someTitle: "Test")
}

