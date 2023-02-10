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
    @ObservedObject private var viewModel: LoginViewModel
  
  init(viewModel: LoginViewModel) {
    self.viewModel = viewModel
  }
    
    var body: some View {
        
        NavigationView {
            ZStack (alignment: .top) {
                Color(UIColor(named: "Gunmetal") ?? UIColor.brown)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack (alignment: .center, spacing: 10){
                        
                        
                        Image("Logo")
                            .resizable()
                            .frame (width: 170, height: 170)
                        
                        HStack {
                          if viewModel.state == .register {
                                Button(action: {
                                  viewModel.switchToLoginTapped()
                                }) {
                                    Text("Switch to Login")
                                }
                                    .frame(width: 220, height:45)
                                    .loginStyle()
                                
                          } else if viewModel.state == .login {
                                Button(action: {
                                    
                                  viewModel.switchToRegistrationTapped()
                                }) {
                                    Text("I Am New Here")
                                        .font(.headline)
                                    
                                }
                                .frame(width: 220, height:45)
                                .loginStyle()
                            }
                        }
                        if viewModel.state == .login {
                            VStack {
                              TextField("Login", text: $viewModel.loginForm.email)
                                    .padding(10)
                                    .loginStyle()
                                SecureField("Password", text: $viewModel.loginForm.password)
                                    .padding(10)
                                    .loginStyle()
                              
                              Button {
                                viewModel.loginButtonTapped()
                              } label: {
                                Text("Sign In")
                                  .frame(width: 100, height:45)
                                  .loginStyle()
                              }
                            }
                            
                        } else {
                            VStack {
                              TextField("First Name", text: $viewModel.registrationForm.firstName)
                                    .padding(10)
                                    .autocorrectionDisabled(true)
                                    .loginStyle()
                              TextField("Last Name", text: $viewModel.registrationForm.lastName)
                                    .padding(10)
                                    .autocorrectionDisabled(true)
                                    .loginStyle()
                              TextField("Email Address", text: $viewModel.registrationForm.email)
                                    .padding(10)
                                    .autocorrectionDisabled(true)
                                    .loginStyle()
                              SecureField("Password", text: $viewModel.registrationForm.password)
                                    .padding(10)
                                    .loginStyle()
                              SecureField("Confirm Password", text: $viewModel.registrationForm.confirmationPassword)
                                    .padding(10)
                                    .loginStyle()
                                
                                Button(action: {
                                  viewModel.registerUserButtonTapped()
                                }) {
                                    Text("Register")
                                }
                                .frame(width: 100, height:45)
                                .loginStyle()
                                
                            }
                        }
                    }
                }
            }
        }
    }
}


struct LoginStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
            .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
            .cornerRadius(10)
           
    }
}

extension View {
    func loginStyle() -> some View {
        modifier(LoginStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            LoginView(viewModel: LoginViewModel(rootViewModel: RootViewModel()))
        }
    }
}
