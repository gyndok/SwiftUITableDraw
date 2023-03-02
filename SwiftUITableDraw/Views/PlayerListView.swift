//
//  PlayerView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/3/23.
//

import SwiftUI

struct PlayerListView: View {
  
  @ObservedObject private var viewModel: PlayerListViewModel
  
  init(viewModel: PlayerListViewModel) {
    self.viewModel = viewModel
  }
  
  /*
   I want to figure out how to receive the clicked tourney from the
   TourneyListView and load it into a @State var tourney.  This will
   load the data at the first part of the Vstack
   
   Then it needs to do an automatic search of the Firestore for the table,
   receive the data and display the players at the table.
   */
  
  
  var body: some View {
    
    
    
    ZStack {
      
      VStack {
        
        Text(viewModel.tourney.festival)
          .font(.body)
          .fontWeight(.semibold)
          .padding(5)
        
        VStack (alignment: .center, spacing: 5) {
          
          Text(viewModel.tourney.event)
            .font(.subheadline)
            .fontWeight(.semibold)
          HStack {
            Text("TODO")
            Text("TODO")
            Text("TODO")
          }
          .font(.footnote)
          .fontWeight(.thin)
          HStack {
            Text("Starting Field: \(viewModel.tourney.startingStack)")
            Text("Players Remaining: TODO")
          }
          
        }.padding()
          .font(.footnote)
          .fontWeight(.thin)
          .cornerRadius(30)
          .background(Color.white)
          .shadow(color: Color.brown.opacity(0.3),
                  radius: 10,
                  x: 0.0, y:12)
          .overlay(
            RoundedRectangle(cornerRadius: 16)
              .stroke(.brown, lineWidth: 4)
          )
      }
      
    }
    
    
    
    
    
    
    List{
      ForEach(viewModel.players.sorted { $0.seatNumber < $1.seatNumber }) { player in
        NavigationLink(destination: PlayerDetailView(player: player)) {
          PlayerCell(player: player)
        }
      }
    }
    
    .listStyle(PlainListStyle())
    
    
  }
  
}




struct PlayerListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack{
      PlayerListView(viewModel: PlayerListViewModel(player: PokerPlayer(firstName: "Test", lastName: "Test", hendonmobURL: "google.com", hometown: "TestHomeTown", tournaments: ["1234"], participatedTables: ["1234"]), tourney: Tournament(buyIn: 1000, days: [], entries: 1000, event: "Test", festival: "Test", startingStack: 1000)))
    }
  }
}







