//
//  LoginView.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isShowSignUpView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    HStack {
                        TextField("Email", text: $viewModel.email).padding()
                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                }.padding()
                ZStack {
                    HStack {
                        SecureField("Password",text: $viewModel.password).padding()
                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                }.padding().padding(.bottom)
                Button(action: {
                    viewModel.login()
                }, label: {
                    Text("Login").font(.system(size: 20,weight: .semibold)).foregroundColor(.black).padding()
                }).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)).disabled(!viewModel.isLoginValid)
                .padding(.bottom)
                NavigationLink(
                    destination: SignUpView(isShowSignUpView: $isShowSignUpView).navigationBarHidden(true),
                    isActive: $isShowSignUpView,
                    label: {
                        Button(action: {
                            print("DEBUG: Go To SignUp is clicked")
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
