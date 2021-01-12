//
//  HomeView.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var AuthViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action: {
                AuthViewModel.logout()
            }, label: {
                Text("Logout").font(.system(size: 20,weight: .semibold)).foregroundColor(.black).padding()
            })
            // MARK: -- ユーザーやデータがnilの際はLoadingやShimmerなどを表示する
            Group {
                if AuthViewModel.currentUser != nil {
                    Text("\(AuthViewModel.currentUser!.username)")
                } else {
                    Text("AuthViewModel.currentUser is nil")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
