
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
  
  @ObservedObject private var viewModel = TourneyListViewModel()
  @State private var searchPlayer = ""
  
  var body: some View {
    
    NavigationView {
      VStack (spacing: 5) {
        TextField("Who are you looking for?", text: $searchPlayer)
          .autocorrectionDisabled(true)
          .padding(.horizontal)
          .frame(height: 55)
          .background(Color(.systemGray6))
          .cornerRadius(10)
        Button (action:{
          
          userDefaults.set(searchPlayer, forKey: K.searchPlayerNameKey)
          viewModel.tournaments.removeAll()
          viewModel.executeTournamentSearch(for: searchPlayer)
          
          
        }, label: {
          Text("Find The Tables")
            .font(.headline)
            .frame(height:45)
            .frame(width: 360)
            .foregroundColor(.brown)
            .background(Color.white)
            .cornerRadius(10)
        })
        .padding()
        .background(
          Color.brown)
        .shadow(color: Color.black.opacity(0.3),
                radius: 10,
                x: 0.0, y:12)
        
        
        List {
          ForEach(viewModel.tournaments.indices, id: \.self) { index in
            let tourney = viewModel.tournaments[index]
            NavigationLink(destination: PlayerListView(tourney: tourney)) {
              TourneyCell(tourney: tourney)
            }
          }
            
        }
        .listStyle(PlainListStyle())
          
      }
    }
  }
}
  
  
  
  
  
  
  struct TourneyListView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationStack{
        TourneyListView()
      }
    }
  }
  
  
  
