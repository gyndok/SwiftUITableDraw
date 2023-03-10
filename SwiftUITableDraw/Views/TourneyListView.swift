
//  TourneyListView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/2/23.





import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

/*
 I want to figure out how to send the clicked tourney from the
 TourneyListView and load it into a @State var tourney in the PlayerListView.
 
 */


let userDefaults = UserDefaults.standard

struct TourneyListView: View {
  
  @ObservedObject private var viewModel: TourneyListViewModel
  
  init(viewModel: TourneyListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
              
      VStack {
        Text(viewModel.playerFullName)
          .font(.body)
          .fontWeight(.semibold)
          .padding(5)
        
        Text(viewModel.player?.hometown ?? "")
          .font(.subheadline)
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

      List {
        ForEach(viewModel.tournamentDays.indices, id: \.self) { index in
          let tournamentDayCell = viewModel.tournamentDays[index]
          NavigationLink(destination:
                          TableListView(viewModel: TableListViewModel(playerTables: viewModel.player?.participatedTables ?? [], tournamentDayCell: tournamentDayCell))) {
            TourneyCell(tournamentDayCell: tournamentDayCell)
          }
        }
      }
      .listStyle(PlainListStyle())
      Spacer()
    }
  }
}

struct TourneyListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack{
      TourneyListView(viewModel: TourneyListViewModel(player: nil))
    }
  }
}



