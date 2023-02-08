
//  TourneyListView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/2/23.





import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore


let userDefaults = UserDefaults.standard

struct TourneyListView: View {
   
    let db = Firestore.firestore()
    
    @State var tables: [PlayerTable] = []
    @State var tourneys: [TableDrawModel] = []
    
    @State var searchPlayer: String = userDefaults.object(forKey: K.searchPlayerNameKey) as? String ?? ""
    

    var body: some View {
        
        VStack (spacing: 10) {
            TextField("Who are you looking for?", text: $searchPlayer)
                .autocorrectionDisabled(true)
                .onTapGesture {
                        print("tapped")
                    }
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            Button (action:{
                
                userDefaults.set(searchPlayer, forKey: K.searchPlayerNameKey)
                tourneys.removeAll()
                db.collection("PokerPlayers").whereField("player", isEqualTo: searchPlayer)
                .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                let data = document.data()
                                if let festival = data["festival"] as? String,
                                    let game = data["event"] as? String,
                                    let event = data["event"] as? String,
                                    let tableNumber = data["tableNumber"] as? Int,
                                    let seatNumber = data["seatNumber"] as? Int,
                                    let day = data["day"] as? Int,
                                    let date = data["restartDate2"] as? String {
                                    let tourney = TableDrawModel(festival: festival, game: game, event: event, tableNumber: tableNumber, seatNumber: seatNumber, day: day, date: date)
                                    print(tourney.festival)
                                    print(tourney.event)
                                    tourneys.append(tourney)
                                }
                            }
                        }
                }
                

                
            }, label: {
                Text("Find The Tables")
                    .font(.headline)
                    .frame(height:45)
                    .frame(width: 360)
                    .foregroundColor(.brown)
                    .background(Color.white)
                    .cornerRadius(10)
            })


        }
        .padding()
        .background(
            Color.brown)
        .shadow(color: Color.black.opacity(0.3),
                radius: 10,
                x: 0.0, y:12)

        List {
            ForEach(tourneys) { tourney in
                NavigationLink(destination: PlayerListView()) {
                    TourneyCell(tourney: tourney)
                }
            }
        }
        .listStyle(PlainListStyle())
    }

    }




struct TourneyListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            TourneyListView()
        }
    }
}



