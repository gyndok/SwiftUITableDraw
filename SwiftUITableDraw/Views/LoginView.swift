//
//  LoginView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/7/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

let LoginUserDefaults = UserDefaults.standard

struct LoginView: View {
    @State private var showLogin = true
    @State private var login = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var passwordConfirm = ""
    
    var body: some View {
        
        ZStack (alignment: .top) {
            Color.brown
                .ignoresSafeArea(.all)
            VStack (alignment: .center, spacing: 15){
                Text("My Table Draw")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 300, height:30)
                    .padding()
                    .foregroundColor(.brown)
                    .background(Color.white)
                    .cornerRadius(10)
                
                
                Image("TableDraw")
                    .resizable()
                    .frame (width: 190, height: 190)
                
                
                HStack {
                    if !showLogin {
                        Button(action: {
                            self.showLogin.toggle()
                        }) {
                            Text("Switch to Login")
                            
                                .font(.headline)
                        }.font(.headline)
                            .frame(height:45)
                            .frame(width: 220)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    } else if showLogin{
                        Button(action: {
                            self.showLogin.toggle()
                        }) {
                            Text("I Am New Here")
                                .font(.headline)
                        }.font(.headline)
                            .frame(height:45)
                            .frame(width: 220)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                }
                .padding()
                //Spacer()
                
                
                if showLogin {
                    VStack {
                        TextField("Login", text: $login)
                            .padding(10)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        SecureField("Password", text: $password)
                            .padding(10)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                       
                        Button(action: {
                            Auth.auth().signIn(withEmail: self.login, password: self.password) { (result, error) in
                                if error != nil {
                                    print("Login failed: \(error!.localizedDescription)")
                                    return
                                }
                                print("Login successful")
                            }
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
                            .padding(10)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        TextField("Last Name", text: $lastName)
                            .padding(10)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        TextField("Email Address", text: $email)
                            .padding(10)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        SecureField("Password", text: $password)
                            .padding(10)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        SecureField("Confirm Password", text: $passwordConfirm)
                            .padding(10)
                            .foregroundColor(.brown)
                            .background(Color.white)
                            .cornerRadius(5.0)
                        
                        
                        
                        Button(action: {
                            Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                                if error != nil {
                                    print("Registration failed: \(error!.localizedDescription)")
                                    return
                                }
                                print("Registration successful")
                            }
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
        NavigationView(){
            LoginView()
        }
    }
}
