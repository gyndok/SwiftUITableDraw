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
    
    VStack {
      VStack(spacing: 2) {
        Text(viewModel.tournamentDayCell?.festival ?? "")
          .font(.body)
          .fontWeight(.semibold)
          .padding(5)

        Text(viewModel.tournamentDayCell?.eventName ?? "")
          .font(.subheadline)
          .fontWeight(.semibold)
        HStack {
          
          Text("Day: \(viewModel.tournamentDayCell?.dayNumber ?? 0)")
          
          Rectangle()
            .frame(width: 1, height: 10)
          
          Text("Restart Date: \(viewModel.tournamentDayCell?.restartDateFormatted ?? "")")
        }
        .foregroundColor(.secondary)
        .font(.caption)
        .fontWeight(.semibold)
        
        HStack {
          Text("Entries: \(viewModel.tournamentDayCell?.totalEntries ?? 0)")
          Rectangle()
            .frame(width: 1, height: 10)
          Text("Players Remaining: \(viewModel.tournamentDayCell?.playersRemaining ?? 0)")
          
        }
        .foregroundColor(.secondary)
        .font(.caption)
        .fontWeight(.semibold)
        
        HStack {
          
          Text("Table: \(viewModel.table?.tableNumber ?? "0")")
          
          
          if let bigBlind = viewModel.tournamentDayCell?.bigBlind {
            Rectangle()
              .frame(width: 1, height: 10)
            Text("Big Blind: \(bigBlind)")
          }
        }
        .foregroundColor(.secondary)
        .font(.caption)
        .fontWeight(.semibold)
      }
      .padding()
      .font(.footnote)
      .fontWeight(.thin)
      .cornerRadius(30)
      .shadow(color: Color.brown.opacity(0.3),
              radius: 10,
              x: 0.0, y:12)
      .overlay(
        RoundedRectangle(cornerRadius: 16)
          .stroke(.brown, lineWidth: 4)
      )
      
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
}

struct TableListView_Previews: PreviewProvider {
  static var previews: some View {
    TableListView(viewModel: TableListViewModel(playerTables: [], tournamentDayCell: TournamentDayCell(tournamentDayID: "123", eventName: "Millionaire Maker", festival: "2019 WSOP", totalEntries: 2000, playersRemaining: 1500, dayNumber: 2, restartDate: Date(), bigBlind: 1000, buyIn: 1500)))
  }
}
