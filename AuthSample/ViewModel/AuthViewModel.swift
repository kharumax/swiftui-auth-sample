//
//  AuthViewModel.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: Error?
    @Published var session: FirebaseAuth.User?
    @Published var currentUser: User?
    
    var isLoginValid: Bool {
        return (!email.isEmpty && !password.isEmpty && password.count >= 6)
    }
    var isSignUpValid: Bool {
        return (isLoginValid && !username.isEmpty)
    }
    
    private let usersRef = Firestore.firestore().collection("users")
    
    init() {
        print("DEBUG: AuthViewModel is init!")
        self.listen()
    }
    
    // MARK: -- Firebase公式推奨.ユーザーの状態が変更されたら呼び出される.
    func listen() {
        print("DEBUG: listen is called")
        self.isLoading = true
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("DEBUG: addStateDidChangeListener is called")
            if let user = user {
                print("DEBUG: user is \(user)")
                self.session = user
                self.fetchCurrentUser()
            } else {
                print("DEBUG: user is nil")
                self.session = nil
                self.isLoading = false
                self.currentUser = nil
            }
        }
    }
    
    func fetchCurrentUser() {
        print("DEBUG: fetchCurrentUser is called")
        self.isLoading = true
        guard let uid = session?.uid else { return }
        usersRef.document(uid).getDocument { (snapshot, error) in
            if let error = error {
                self.error = error
                print("DEBUG: Error is \(error.localizedDescription) at fetchCurrentUser")
                return
            }
            guard let data = snapshot?.data() else {
                print("DEBUG: data is nil and in guard at fetchCurrentUser ")
                return
            }
            self.currentUser = User(dictionary: data)
            print("DEBUG: currentUser's data is \(data.debugDescription) at fetchCurrentUser")
            self.isLoading = false
            print("DEBUG: fetchCurrentUser is success!")
        }
    }
    
    func signUp() {
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                print("Error: Error is \(error.localizedDescription) at signUp")
                return
            }
            guard let uid = result?.user.uid else { return }
            let data = ["uid": uid,"username": self.username,"email": self.email]
            let ref = self.usersRef.document(uid)
            ref.setData(data) { error in
                if let error = error {
                    self.error = error
                    self.isLoading = false
                    print("Error: Error is \(error.localizedDescription) in setData at signUp")
                    return
                }
                self.currentUser = User(dictionary: data)
                self.clearCredentialInfo()
                print("DEBUG: signUp is success")
            }
        }
    }
    
    func login() {
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                print("Error: Error is \(error.localizedDescription) at login")
                return
            }
            self.clearCredentialInfo()
            print("DEBUG: login is success")
        }
    }
    
    func logout() {
        self.isLoading = true
        do {
            try Auth.auth().signOut()
        } catch {
            self.isLoading = false
            self.error = error
            print("DEBUG: Error is \(error.localizedDescription) at logout")
        }
    }
    
    func clearCredentialInfo() {
        self.email = ""
        self.username = ""
        self.password = ""
    }
    
}


