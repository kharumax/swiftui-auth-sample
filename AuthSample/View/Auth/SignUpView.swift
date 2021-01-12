//
//  SignUpView.swift
//  AuthSample
//
//  Created by 久保田陽人 on 2021/01/12.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var isShowSignUpView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack {
                    TextField("Username", text: $viewModel.username).padding()
                }.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            }.padding()
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
                viewModel.signUp()
            }, label: {
                Text("SignUp").font(.system(size: 20,weight: .semibold)).foregroundColor(.black).padding()
            }).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)).disabled(!viewModel.isSignUpValid)
            .padding(.bottom)
            Button(action: {
                self.isShowSignUpView = false
            }, label: {
                Text("Go To Login").font(.system(size: 20,weight: .semibold)).foregroundColor(.black).padding()
            }).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            .padding(.bottom)
            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isShowSignUpView: .constant(true))
    }
}
