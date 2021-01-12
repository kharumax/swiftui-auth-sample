//
//  AuthSampleApp.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI
import Firebase

@main
struct AuthSampleApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel())
        }
    }
}
