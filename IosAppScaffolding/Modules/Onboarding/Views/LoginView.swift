//
//  LoginView.swift
//  SwiftuiAuthBase
//
//  Created by Christophe Guégan on 10/07/2024.
//

import SwiftUI

struct LoginView: View {
    
    /// State Properties
    @State private var login = LoginManager()
    
    /// Main View
    var body: some View {
        NavigationStack {
            VStack {
                logoImageView
                appTitle
                appIntro
                formFieldsView
                forgotPasswordButton
                signInButton
                Spacer()
                signUpButton
            }
            .frame(maxWidth: AppConstants.maxWidth)
            .sheet(isPresented: $login.showResetPasswordSheet) {
                ResetPasswordView(service: login)
                    .presentationDetents([.medium])
            }
            .alert("Error", isPresented: $login.showingAlert) {
                Button("OK", role: .cancel) {
                    login.showingAlert = false
                    login.errorMessage = ""
                }
            } message: {
                Text(login.errorMessage)
            }
        }
    }
}


// MARK: - Subviews
// ————————————————

extension LoginView {
    
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
            ImputView( text: $login.email,
                       title: "Email Address",
                       placeholder: "name@example.com"
            )
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            
            // Password
            ImputView( text: $login.password,
                       title: "Password",
                       placeholder: "Enter your password",
                       isSecuredField: true
            )
            .autocapitalization(.none)
        }
        .padding(.horizontal)
        .padding(.top, 12)
        
    }
    
    // Forgot Password
    var forgotPasswordButton: some View {
        Button {
            login.showResetPasswordSheet.toggle()
        } label: {
            HStack(spacing: 4) {
                Text("Forgot your password?")
                    .font(.caption)
            }
        }
        .padding(.top)
        .frame( maxWidth: .infinity,
                alignment: .trailing)
    }
       
    // Sign in Button
    var signInButton: some View {
        Button {
            login.signIn()
        } label: {
            HStack {
                Text("Sign In")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
        }
        .background(Color(.systemBlue))
        .disabled(!login.isSignInValid)
        .opacity(login.isSignInValid ? 1.0 : 0.5)
        .cornerRadius(10)
        .padding(.top, 24)
    }
    
    // Sign up button
    var signUpButton: some View {
        NavigationLink {
            RegistrationView()
                .navigationBarBackButtonHidden(true)
        } label: {
            HStack(spacing: 4) {
                Text("Don't have an account?")
                Text("Sign Up")
                    .bold()
            }
        }
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    LoginView()
}
