//
//  PlayerListViewModel.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/24/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class PlayerListViewModel: ObservableObject {
  
  @Published var players = [PokerPlayer]()
  private let tourney: Tournament
  private let currentUser: PokerPlayer
  private let db = Firestore.firestore()
  
  init(player: PokerPlayer, tourney: Tournament) {
    currentUser = player
    self.tourney = tourney
  }
  
  func displayPlayersForLatestTable() {
    // get latest day of tourney
    guard let latestDay = tourney.days.last else { return }
    if currentUser.participatedTables.contains(latestDay) {
      fetchPlayers(for: latestDay)
    }
  }
  
  private func fetchPlayers(for tableID: String) {
    db.collection("Tables").getDocuments { [weak self] snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot,
              let document = snapshot.documents.first(where: { $0.documentID == tableID}),
              let table = try? document.data(as: Table.self)
        else {
          return
        }
        let tablePlayerIDs = table.seats
        self?.fetchTablePlayers(for: Set(tablePlayerIDs))
      }
    }
  }
  
  private func fetchTablePlayers(for tablePlayerIDs: Set<String>) {
    db.collection("TablePlayers").getDocuments { [weak self] snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot
        else {
          return
        }
        let documents = snapshot.documents.filter({ tablePlayerIDs.contains($0.documentID) })
        let tablePlayers = documents.compactMap({ try? $0.data(as: TablePlayer.self)})
        for tablePlayerID in tablePlayerIDs {
          self?.fetchPokerPlayer(for: tablePlayerID) { result in
            switch result {
            case .failure(let error):
              print(error)
            case .success(let pokerPlayer):
              guard let pokerPlayer = pokerPlayer else { return }
              self?.players.append(pokerPlayer)
            }
          }
        }
      }
    }
  }
  
  private func fetchPokerPlayer(for playerID: String, result: @escaping (Result<PokerPlayer?, Error>) -> Void ) {
    db.collection("PokerPlayers").getDocuments { snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
        result(.failure(error))
      } else {
        guard let snapshot = snapshot
        else {
          return
        }
        guard let document = snapshot.documents.first(where: { $0.documentID == playerID}) else { return }
        result(.success(try? document.data(as: PokerPlayer.self)))
      }
        
    }
  }
  
}
