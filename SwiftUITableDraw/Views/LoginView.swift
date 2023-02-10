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
                    VStack (alignment: .center, spacing: 15){
                        
                        
                        Image("Logo")
                            .resizable()
                            .frame (width: 170, height: 170)
                        
                        HStack {
                          if viewModel.state == .register {
                                Button(action: {
                                  viewModel.switchToLoginTapped()
                                }) {
                                    Text("Switch to Login")
                                    
                                        .font(.headline)
                                }
                                .font(.headline)
                                    .frame(height:45)
                                    .frame(width: 220)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(10)
                                
                          } else if viewModel.state == .login {
                                Button(action: {
                                    
                                  viewModel.switchToRegistrationTapped()
                                }) {
                                    Text("I Am New Here")
                                        .font(.headline)
                                    
                                }.font(.headline)
                                    .frame(height:45)
                                    .frame(width: 220)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(10)
                            }
                        }
                        if viewModel.state == .login {
                            VStack {
                              TextField("Login", text: $viewModel.loginForm.email)
                                    .padding(10)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(5.0)
                                SecureField("Password", text: $viewModel.loginForm.password)
                                    .padding(10)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(5.0)
                              
                              Button {
                                viewModel.loginButtonTapped()
                              } label: {
                                Text("Sign In")
                                  .font(.headline)
                                  .frame(height:45)
                                  .frame(width: 100)
                                  .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                  .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                  .cornerRadius(10)
                              }
                            }
                            
                        } else {
                            VStack {
                              TextField("First Name", text: $viewModel.registrationForm.firstName)
                                    .padding(10)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(5.0)
                              TextField("Last Name", text: $viewModel.registrationForm.lastName)
                                    .padding(10)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(5.0)
                              TextField("Email Address", text: $viewModel.registrationForm.email)
                                    .padding(10)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(5.0)
                              SecureField("Password", text: $viewModel.registrationForm.password)
                                    .padding(10)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(5.0)
                              SecureField("Confirm Password", text: $viewModel.registrationForm.confirmationPassword)
                                    .padding(10)
                                    .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                    .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                    .cornerRadius(5.0)
                                
                                Button(action: {
                                  viewModel.registerUserButtonTapped()
                                }) {
                                    Text("Register")
                                }
                                .font(.headline)
                                .frame(height:45)
                                .frame(width: 100)
                                .foregroundColor(Color(UIColor(named: "Gunmetal") ?? UIColor.brown))
                                .background(Color(UIColor(named: "Saffron") ?? UIColor.brown))
                                .cornerRadius(10)
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            LoginView(viewModel: LoginViewModel(rootViewModel: RootViewModel()))
        }
    }
}
