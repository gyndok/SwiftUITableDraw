//
//  TourneyListViewModel.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/22/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class TourneyListViewModel: ObservableObject {
  
  @Published var tournamentDays = [TournamentDayCell]()
  
  private let db = Firestore.firestore()
  let player: PokerPlayer?
  
  var playerFullName: String {
    guard let player = player else { return "" }
    return player.firstName + " " + player.lastName
  }
  
  init(player: PokerPlayer?) {
    self.player = player
    executeTournamentSearch()
  }
  
  private func executeTournamentSearch() {
    let tournamentGroup = DispatchGroup()
    
    tournamentGroup.enter()
    db.collection("Tournaments").getDocuments { [weak self] snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot else { return }
        let tournaments: [Tournament] = snapshot.documents.compactMap({
          if let tournaments = self?.player?.tournaments {
            let tournamnetSet = Set(tournaments)
            if tournamnetSet.contains($0.documentID) {
              var tournament = try? $0.data(as: Tournament.self)
              tournament?.tournamentID = $0.documentID
              return tournament
            }
          }
          return nil
        })
        let tournamentGroup = DispatchGroup()
        var temporaryCellArray = [TournamentDayCell]()
        
        
        for tournament in tournaments {
          tournamentGroup.enter()
          for (index, day) in tournament.days.enumerated() {
            self?.loadTournamentDay(for: day) { result in
              switch result {
              case .success(let tournamentDay):
                let cell = TournamentDayCell(tournamentDayID: day, eventName: tournament.event, festival: tournament.festival, totalEntries: tournament.entries, playersRemaining: tournamentDay.playersRemaining, dayNumber: UInt(index + 2), restartDate: tournamentDay.restartDate.dateValue(), bigBlind: tournamentDay.bigBlind, buyIn: tournament.buyIn)
                temporaryCellArray.append(cell)
                tournamentGroup.leave()
              case .failure(let error):
                print(error)
              }
            }
          }
        }
        
        tournamentGroup.notify(queue: .main) {
          self?.tournamentDays = temporaryCellArray.sorted(by: { $0.restartDate > $1.restartDate })
        }
      }
    }
  }
  
  private func loadTournamentDay(for tournamentDayID: String, completion: @escaping (Result<TournamentDay, Error>) -> Void) {
    db.collection("TournamentDays").getDocuments { snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot,
              let document = snapshot.documents.first(where: { $0.documentID == tournamentDayID }),
              let tournamentDay = try? document.data(as: TournamentDay.self)
        else { return }
        completion(.success(tournamentDay))
      }
    }
  }
}

struct TournamentDayCell {
  let tournamentDayID: String
  let eventName: String
  let festival: String
  let totalEntries: UInt
  let playersRemaining: UInt
  let dayNumber: UInt
  let restartDate: Date
  let bigBlind: UInt?
  let buyIn: UInt
  
  var restartDateFormatted: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    return dateFormatter.string(from: restartDate)
  }
}
