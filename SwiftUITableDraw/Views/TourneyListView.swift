
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
      List {
        ForEach(viewModel.tournaments.indices, id: \.self) { index in
          let tourney = viewModel.tournaments[index]
          TourneyCell(tourney: tourney)
        }
      }
      .listStyle(PlainListStyle())
      Spacer()
    }.onAppear {
      viewModel.executeTournamentSearch()
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



