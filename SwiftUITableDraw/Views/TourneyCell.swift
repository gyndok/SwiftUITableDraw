//
//  TourneyCell.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/2/23.
//

import SwiftUI

struct TourneyCell: View {
    
    let tournamentDayCell: TournamentDayCell
    
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
        
        VStack(spacing: 0){
          
          Text(tournamentDayCell.festival)
            .minimumScaleFactor(0.7)
            .lineLimit(1)
            .foregroundColor(.primary)
            .font(.subheadline)
            .fontWeight(.bold)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .underline()
          
          Text(tournamentDayCell.eventName)
            .minimumScaleFactor(0.7)
            .lineLimit(1)
            .foregroundColor(.primary)
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          HStack {
            Text("Day: \(tournamentDayCell.dayNumber)")
            Rectangle()
              .frame(width: 1, height: 10)
            Text("Restart Date: \(tournamentDayCell.restartDateFormatted)")
          }
          .foregroundColor(.secondary)
          .font(.caption)
          .fontWeight(.semibold)
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          HStack {
            
            Text("Buy In: \(tournamentDayCell.buyIn)")
            Rectangle()
              .frame(width: 1, height: 10)
            Text("Entries: \(tournamentDayCell.totalEntries)")
            if let bigBlind = tournamentDayCell.bigBlind {
              Rectangle()
                .frame(width: 1, height: 10)
              Text("Big Blind: \(bigBlind)")
            }
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
    
  static var tournamentDayCell = TournamentDayCell(tournamentDayID: "123", eventName: "Millionaire Maker", festival: "2019 WSOP", totalEntries: 2000, playersRemaining: 1500, dayNumber: 2, restartDate: Date(), bigBlind: 1000, buyIn: 1500)
    static var previews: some View {
        
        TourneyCell(tournamentDayCell: tournamentDayCell)
        
    }
     


    }

