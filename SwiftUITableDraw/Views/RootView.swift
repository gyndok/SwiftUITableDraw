//
//  RootView.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/10/23.
//

import SwiftUI

struct RootView: View {
  @ObservedObject private var viewModel = RootViewModel()
  
    var body: some View {
      switch viewModel.state {
//      case .loggedOut:
//        LoginView(viewModel: LoginViewModel(rootViewModel: viewModel))
      case .loggedOut, .loggedIn:
        PlayerSearchView()
      }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
