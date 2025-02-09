//
//  AuthService.swift
//  SwiftuiAuthBase
//
//  Created by Christophe Guégan on 11/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

// TODO: - Implement delete account

@Observable
final class AuthService {
    
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    
    static let shared = AuthService()
    
    /// Firestore database reference
    ///
    let db = Firestore.firestore()
    let collectionName = "users"
    var listener: ListenerRegistration?
    
    /// Private init
    /// Not Accessible from outstide because of the singleton pattern used here
    ///
    private init() {
        userSession = Auth.auth().currentUser
        if userSession != nil {
            Task {
                try await fetchUser()
            }
        }
    }
    
    /// Sign In
    /// 
    /// - Parameters:
    ///   - email: String - Email address of the new user
    ///   - password: String - Chosen password
    ///
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            try await fetchUser()
        } catch {
            throw(error)
        }
    }
    
    /// Create User
    /// 
    /// - Parameters:
    ///   - email: String - Email address of the new user
    ///   - password: String - Chosen password
    ///   - fullName: String - Full name of the new user
    ///
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        print("DEBUG: creating user from service ...")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User( id: result.user.uid,
                             email: email,
                             fullName: fullName,
                             profilePicture: "" )
            let encodedUser = try Firestore.Encoder().encode(user)
            try await db.collection(collectionName).document(result.user.uid).setData(encodedUser)
            try await fetchUser()
        } catch {
            throw(error)
        }
    }
    
    /// Sign Out
    ///
    func signOut() throws {
        print("DEBUG: Signing out ...")
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            throw(error)
        }
    }
    
    /// Delete account
    ///
    func deleteAccount() {
        print("DEBUG: Deleting Account from service ...")
        // Delete all sub collections
    }
    
    /// Fetch user
    ///
    func fetchUser() async throws {
        print("DEBUG: Fetching user from service ...")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: User.self)
            self.currentUser = user
            print("DEBUG: fetch the user: \(self.currentUser?.fullName ?? "")")

        } catch  {
            throw(error)
        }
    }
    
    /// Forgot Password
    ///
    func resetPassword(withEmail email: String) async throws {
        print("DEBUG: Reset password ...")
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw(error)
        }
        
    }
    
    /// Change Password
    ///
    func changePassword() async {}
    
}
