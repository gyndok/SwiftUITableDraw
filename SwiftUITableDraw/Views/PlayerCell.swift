//
//  PlayerCell.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/3/23.
//

import SwiftUI

let player = PlayerModel(playerName: "Geffrey Klein", hometown: "Houston, Texas", tableNumber: 278, seatNumber: 3, chipCount: "$236,000", bigBlinds: 23.6)



struct PlayerCell: View {
    
    
    let player: PlayerModel
    
    var body: some View {
        
            HStack(spacing: 30){
                Image(systemName: player.symbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.brown)
                    .frame(minWidth: 25, maxWidth: 25, alignment: .center)
                    .padding()
                    .shadow(color: Color.brown.opacity(0.6),
                            radius: 10,
                            x: 0.0, y:12)
                  
                
                    VStack{
                    
                        Text(player.playerName)
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
                        HStack{
                            Text("Chips: \(player.chipCount) ")
                            Text("\(player.bigBlindsString)")
                        }
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
              
            }
        
            

        }
    }


struct PlayerCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCell(player: player)
    }
}


