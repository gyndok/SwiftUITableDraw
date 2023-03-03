//
//  TableListView.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 3/1/23.
//

import SwiftUI

struct TableListView: View {
  
  @ObservedObject private var viewModel: TableListViewModel
  
  init(viewModel: TableListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    List{
      ForEach(viewModel.players) { player in
        NavigationLink(destination: PlayerDetailView(player: player)) {
          PlayerCell(player: player)
        }
      }
    }
    
    .listStyle(PlainListStyle())
  }
}

struct TableListView_Previews: PreviewProvider {
  static var previews: some View {
    TableListView(viewModel: TableListViewModel(tournamentDayID: nil, playerTables: []))
  }
}
