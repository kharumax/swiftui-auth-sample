//
//  ContentView.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI

struct ContentView: View {
    
    let isShowHomeView = false
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            if viewModel.session != nil {
                NavigationView {
                    MainTabView(selectedIndex: $selectedIndex)
                        .padding(.top,8)
                        .navigationTitle("ホーム")
                        .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
