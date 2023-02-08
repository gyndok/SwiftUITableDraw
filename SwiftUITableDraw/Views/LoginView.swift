//
//  LoginView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/7/23.
//

import SwiftUI

struct LoginView: View {
    @State private var showLogin = true
    @State private var login = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var passwordConfirm = ""
    
    var body: some View {
        
        ZStack {
            Color.brown
                .ignoresSafeArea(.all)
            VStack {
                Image("TableDraw")
                    .resizable()
                    .frame (width: 215, height: 200)
               
                HStack {
                    Button(action: {
                        self.showLogin = true
                    }) {
                        Text("Login")
                            
                            .font(.headline)
                    }.font(.headline)
                        .frame(height:45)
                        .frame(width: 100)
                        .foregroundColor(.brown)
                        .background(Color.white)
                        .cornerRadius(10)
                    Spacer()
                    Button(action: {
                        self.showLogin = false
                    }) {
                        Text("Register")
                            .font(.headline)
                    }.font(.headline)
                        .frame(height:45)
                        .frame(width: 100)
                        .foregroundColor(.brown)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding()
                
                if showLogin {
                    VStack {
                        TextField("Login", text: $login)
                            .padding()
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        SecureField("Password", text: $password)
                            .padding()
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        Button(action: {
                            // Login logic
                        }) {
                            Text("Sign In")
                        }
                        .font(.headline)
                            .frame(height:45)
                            .frame(width: 100)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                } else {
                    VStack {
                        TextField("First Name", text: $firstName)
                            .padding()
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        TextField("Last Name", text: $lastName)
                            .padding()
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        TextField("Email Address", text: $email)
                            .padding()
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        SecureField("Password", text: $password)
                            .padding()
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        SecureField("Confirm Password", text: $passwordConfirm)
                            .padding()
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        Button(action: {
                            // Register logic
                        }) {
                            Text("Register")
                        }
                        .font(.headline)
                            .frame(height:45)
                            .frame(width: 100)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
