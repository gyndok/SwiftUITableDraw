//
//  TourneyCell.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/2/23.
//

import SwiftUI

struct TourneyCell: View {
    
    let tourney: Tournament
    
    var body: some View {
        HStack(spacing: 10){
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
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .underline()
                    
                    Text(tourney.event)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Day: Day")
                        Text("Restart Date: Date")
                    }
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                HStack {
                   
                    Text("Buy In: \(tourney.buyIn)")
                    Text("Entries: \(tourney.entries)")
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
    
    static var tourney1 =  Tournament(buyIn: 1500, days: ["2"], entries: 2000, event: "Millionaire Maker", festival: "2019 WSOP", startingStack: 1500)
    static var tourney2 =  Tournament(buyIn: 10000, days: ["1"], entries: 7200, event: "Main Event", festival: "2019 WSOP", startingStack: 10000)
    static var previews: some View {
        
        TourneyCell(tourney: tourney1)
        
    }
     


    }

