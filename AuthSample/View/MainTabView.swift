//
//  MainTabView.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI

struct MainTabView: View {
    
    @Binding var selectedIndex: Int

    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .onTapGesture {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }
                .tag(0)
            ProfileView()
                .onTapGesture {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("プロフィール")
                }
                .tag(1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedIndex: .constant(0))
    }
}
