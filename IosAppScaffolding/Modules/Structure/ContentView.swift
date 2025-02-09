//
//  ContentView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    // MARK: - Main View
    // —————————————————
    var body: some View {
        Group {
            if AuthService.shared.userSession != nil {
                /// swich to view depending on the user device
                switch UIDevice.current.userInterfaceIdiom {
                    case .phone:
                        IphoneTabView()
                    case .pad:
                        IpadTabView()
                    default:
                    IphoneTabView()
                }
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
