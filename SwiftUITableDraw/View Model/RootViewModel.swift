//
//  RootViewModel.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/10/23.
//

import Foundation

class RootViewModel: ObservableObject {
  
  enum State {
    case loggedOut
    case loggedIn
  }
  
  @Published var state: State = .loggedOut
}
