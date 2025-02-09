//
//  RegistrationView.swift
//  SwiftuiAuthBase
//
//  Created by Christophe Guégan on 10/07/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    /// Environment Properties
    @Environment(\.dismiss) var dismiss
    
    /// State Properties
    @State private var registration = LoginManager()

    /// Constants
    let appName = "Sample App"
    let maxWidth: CGFloat = 350
    
    /// Main View
    var body: some View {
        VStack {
            logoImageView
            appTitle
            appIntro
            formFieldsView
            signUpButton
            Spacer()
            signInButton
        }
        .frame(
            maxWidth: AppConstants.maxWidth,
            maxHeight: .infinity,
            alignment: .center
        )
    }
}

// MARK: - Subviews
// ————————————————

extension RegistrationView {
    
    // Logo
    var logoImageView: some View {
            Image("Corail_280")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150, alignment: .center)
                .padding(.vertical, 32)
    }
    
    // App Title
    var appTitle: some View {
        Text(AppConstants.appName)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }
    
    // App Introduction Text
    var appIntro: some View {
        Text(AppConstants.introText)
            .font(.headline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
    }
    
    // Form fields
    var formFieldsView: some View {
        
        VStack(spacing: 24) {
            // Email
            ImputView( text: $registration.email,
                       title: "Email Address",
                       placeholder: "name@example.com"
            )
            .autocapitalization(.none)
            
            // Full Name
            ImputView( text: $registration.fullName,
                       title: "Enter your name",
                       placeholder: "John Doe"
            )
            
            // Password
            ImputView( text: $registration.password,
                       title: "Password",
                       placeholder: "Enter your password",
                       isSecuredField: true
            )
            .autocapitalization(.none)
            
            // Confirmed Password
            ZStack(alignment: .trailing) {
                ImputView( text: $registration.confirmPassword,
                           title: "Confirm Password",
                           placeholder: "Confirm your password",
                           isSecuredField: true
                )
                .autocapitalization(.none)
                
                if !registration.password.isEmpty &&
                    registration.password == registration.confirmPassword {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 12)
        
    }
    
    // Sign up Button
    var signUpButton: some View {
        Button {
            registration.createUser()
        } label: {
            HStack {
                Text("Sign Up").fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
        }
        .background(Color(.systemBlue))
        .disabled(!registration.isRegisterValid)
        .opacity(registration.isRegisterValid ? 1.0 : 0.5)
        .cornerRadius(10)
        .padding(.top, 24)
    }
    
    // // Sign in button
    var signInButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 4) {
                Text("Already have an account?")
                Text("Sign In")
                    .bold()
            }
        }
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    RegistrationView()
}
