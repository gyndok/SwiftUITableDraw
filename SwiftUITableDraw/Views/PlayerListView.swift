//
//  PlayerView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/3/23.
//

import SwiftUI

struct PlayerListView: View {
    
    @State var players: [PlayerModel] = [
        PlayerModel(playerName: "Geffrey Klein", hometown: "Houston, Texas", tableNumber: 278, seatNumber: 3, chipCount: "$236,000", bigBlinds: 23.6),
        PlayerModel(playerName: "Sean Grover", hometown: "WESTMONT, QC, CA", tableNumber: 278, seatNumber: 1, chipCount: "$492,000", bigBlinds: 49.2),
        PlayerModel(playerName: "Anthony Spinella", hometown: "WAXHAW, NC, US", tableNumber: 278, seatNumber: 5, chipCount: "$512,000", bigBlinds: 51.2)]
    
    var body: some View {
        
        
            List{
                ForEach(players.sorted { $0.seatNumber < $1.seatNumber }) { player in
                    PlayerCell(player: player)
                }
            }
            .listStyle(PlainListStyle())
        
    }
    
    
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PlayerListView()
        }
    }
}







