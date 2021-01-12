//
//  LoginView.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var isShowSignUpView = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack {
                    TextField("Email", text: $email).padding()
                }.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            }.padding()
            ZStack {
                HStack {
                    SecureField("Password",text: $password).padding()
                }.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            }.padding().padding(.bottom)
            Button(action: {}, label: {
                Text("Login").font(.system(size: 20,weight: .semibold)).foregroundColor(.black).padding()
            }).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            .padding(.bottom)
            NavigationLink(
                destination: SignUpView(isShowSignUpView: $isShowSignUpView).navigationBarHidden(true),
                isActive: $isShowSignUpView,
                label: {
                    Button(action: {
                        self.isShowSignUpView = true
                    }, label: {
                        Text("Go To SignUp").font(.system(size: 20,weight: .semibold)).foregroundColor(.black).padding()
                    }).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                    .padding(.bottom)
                })
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
