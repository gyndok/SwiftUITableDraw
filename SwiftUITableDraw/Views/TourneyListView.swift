
//  TourneyListView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/2/23.





import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore



let userDefaults = UserDefaults.standard
let db = Firestore.firestore()


struct TourneyListView: View {
    
    @State var tables: [PlayerTable] = []

    @State var tourneys: [TableDrawModel] = [
        TableDrawModel(festival: "2021 World Series of Poker", game: "NLHE", event: "Event 70: $10,000 Main Event", tableNumber: 234, seatNumber: 5, day: 2, date: "10/7/2021"),
        TableDrawModel(festival: "2022 World Series of Poker", game: "NLHE", event: "Event 10: $1500 NLHE", tableNumber: 119, seatNumber: 9, day: 3, date: "6/30/2022"),
        TableDrawModel(festival: "2023 World Series of Poker", game: "NLHE", event: "Event 1: Casino Employee Event", tableNumber: 91, seatNumber: 8, day: 2, date: "5/31/2023")
    ]
    
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
                print("User Saved")
                fetchTourneys(collection: K.dbCollection, field: K.searchPlayerNameKey, player: searchPlayer)
                print("function used")

                
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

func fetchTourneys (collection: String, field: String, player: String){
    print("1")
    
    
    db.collection(collection).whereField(field, isEqualTo: player)
    .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("2")
                    print("\(document.documentID) => \(document.data())")
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



