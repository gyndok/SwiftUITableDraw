//
//  TourneyCell.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/2/23.
//

import SwiftUI

struct TourneyCell: View {
    
    
    let tourney: TableDrawModel
    
    var body: some View {
        HStack(spacing: 30){
            Image("WSOP")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 50, maxWidth: 50, alignment: .top)
               .clipShape(Rectangle())
               .padding()
               .shadow(color: Color.brown.opacity(0.6),
                       radius: 10,
                       x: 0.0, y:12)
            
                VStack{
                
                    Text(tourney.festival)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .underline()
                    
                    Text(tourney.event)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Day: \(tourney.day)")
                        Text("Restart Date: \(tourney.date)")
                    }
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                HStack {
                   
                    Text("Table: \(tourney.tableNumber)")
                    Text("Seat: \(tourney.seatNumber)")
                }
                .foregroundColor(.secondary)
                .font(.caption)
                .fontWeight(.semibold)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }

                
        }
    
        

    }
     
}

struct TourneyCell_Previews: PreviewProvider {
    static var tourney1 =    TableDrawModel(festival: "2023 World Series of Poker", game: "NLHE", event: "Event 1: Casino Employee Event", tableNumber: 91, seatNumber: 8, day: 2, date: "5/31/2023")
    static var tourney2 = TableDrawModel(festival: "2022 World Series of Poker", game: "NLHE", event: "Event 10: $1500 NLHE", tableNumber: 119, seatNumber: 9, day: 3, date: "6/30/2022")
    static var previews: some View {
        Group{
            TourneyCell(tourney: tourney1)
            TourneyCell(tourney: tourney2)
        }
        .previewLayout(.sizeThatFits)
      
        
    }
}
