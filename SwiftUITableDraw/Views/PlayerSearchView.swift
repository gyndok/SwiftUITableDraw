//
//  PlayerSearchView.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 3/1/23.
//

import SwiftUI

struct PlayerSearchView: View {
  
  @ObservedObject private var viewModel = PlayerSearchViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Who are you looking for?", text: $viewModel.searchField)
          .autocorrectionDisabled(true)
          .padding(.horizontal)
          .frame(height: 55)
          .background(Color(.systemGray6))
          .cornerRadius(10)
        
        Button {
          viewModel.players.removeAll()
          viewModel.searchButtonPressed()
        } label: {
          Text("Search")
            .font(.headline)
            .frame(height:45)
            .frame(width: 360)
            .foregroundColor(.brown)
            .background(Color.white)
            .cornerRadius(10)
        }
        .padding()
        .background(
          Color.brown)
        .shadow(color: Color.black.opacity(0.3),
                radius: 10,
                x: 0.0, y:12)
        
        List {
          ForEach(viewModel.players.indices, id: \.self) { index in
            let player = viewModel.players[index]
            NavigationLink(destination: TourneyListView(viewModel: TourneyListViewModel(player: player))) {
              PlayerSearchCell(player: player)
            }
          }
        }
        
        Spacer()
      }
    }
  }
}

struct PlayerSearchCell: View {
  private let player: PokerPlayer
  
  init(player: PokerPlayer) {
    self.player = player
  }
  
  var body: some View {
    VStack(spacing: 10) {
      Text(player.firstName + " " + player.lastName)
        .foregroundColor(.primary)
        .font(.subheadline)
        .fontWeight(.bold)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .underline()
      Text(player.hometown)
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .foregroundColor(.primary)
        .font(.subheadline)
        .fontWeight(.semibold)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
  }
}

struct PlayerSearchView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerSearchView()
  }
}
