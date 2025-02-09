//
//  LoginService.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import Foundation
import Observation

@Observable
class LoginManager {
    
    var email: String = ""
    var fullName: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var resetPasswordEmail: String = ""
    var showResetPasswordSheet: Bool = false
    var showingAlert: Bool = false
    var errorMessage: String = ""
    
    /// Validate the signin form
    ///
    var isSignInValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && email.isValidEmail()
    }
    
    /// Validate the register form
    ///
    var isRegisterValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password == confirmPassword
        && password.count > 5
        && email.isValidEmail()
    }
    
    /// Validate the form elements
    ///
    var isValidEmail: Bool {
        email.isValidEmail()
    }
    
    /// Sign In User
    ///
    func signIn() {
        Task {
            do {
                guard isSignInValid else { return }
                try await AuthService.shared.signIn(withEmail: email, password: password)
            } catch {
                errorMessage = error.localizedDescription
                showingAlert = true
            }
        }
    }
    
    /// Reset Password
    ///
    func resetPassword() {
        Task {
            do {
                guard isValidEmail else { return }
                try await AuthService.shared.resetPassword(withEmail: resetPasswordEmail)
                showResetPasswordSheet = false
            } catch {
                print("DEBUG: Error login user: \(error.localizedDescription)")
            }
        }
    }
    
    /// Create User
    ///
    func createUser() {
        Task {
            do {
                guard isSignInValid else { return }
                try await AuthService.shared.createUser( withEmail: email,
                                                         password: password,
                                                         fullName: fullName )
            } catch {
                print("DEBUG: Error creating user: \(error.localizedDescription)")
            }
        }
    }
    
}
