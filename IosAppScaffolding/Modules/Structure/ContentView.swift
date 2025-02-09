//
//  ContentView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var authService = AuthService()
        
    // MARK: - Main View
    // —————————————————
    var body: some View {
        Group {
            if AuthService.shared.userSession != nil {
                IphoneTabView()
            } else {
                LoginView()
            }
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    ContentView()
}
