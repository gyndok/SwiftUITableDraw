//
//  LoginViewModel.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/10/23.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
  
  enum LoginState {
    case login
    case register
  }
  
  struct RegistrationForm {
    var firstName = String()
    var lastName = String()
    var email = String()
    var password = String()
    var confirmationPassword = String()
  }
  
  struct LoginForm {
    var email = String()
    var password = String()
  }
  
  private let rootViewModel: RootViewModel
  
  @Published var state: LoginState = .login {
    didSet {
      if state == .register {
        registrationForm = RegistrationForm()
      }
      else if state == .login {
        loginForm = LoginForm()
      }
    }
  }
  @Published var registrationForm = RegistrationForm()
  @Published var loginForm = LoginForm()
  
  init(rootViewModel: RootViewModel) {
    self.rootViewModel = rootViewModel
  }
  
  
  @MainActor
  func switchToLoginTapped() {
    state = .login
  }
  
  @MainActor
  func switchToRegistrationTapped() {
    state = .register
  }
  
  @MainActor
  func registerUserButtonTapped() {
    Auth.auth().createUser(withEmail: registrationForm.email, password: registrationForm.password) { [weak self] (result, error) in
        if error != nil {
            print("Registration failed: \(error!.localizedDescription)")
            return
        }
        // Take token from result and use in FireStore add user request.
        // Add request to add user to my FireStore
      self?.rootViewModel.state = .loggedIn
    }
  }
  
  @MainActor
  func loginButtonTapped() {
    Auth.auth().signIn(withEmail: loginForm.email, password: loginForm.password) { [weak self] (result, error) in
        if error != nil {
            print("Login failed: \(error!.localizedDescription)")
            return
        }
      self?.rootViewModel.state = .loggedIn
    }
  }
  
}
