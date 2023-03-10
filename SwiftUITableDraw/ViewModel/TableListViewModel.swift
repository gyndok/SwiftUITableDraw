//
//  TableListViewModel.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 3/1/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class TableListViewModel: ObservableObject {
  @Published var players = [PlayerModel]()
  @Published var table: Table?
  let tournamentDayCell: TournamentDayCell?
  
  @Published var state = State.success
  
  private let playerTables: [String]
  private let db = Firestore.firestore()
  
  enum State {
    case success
    case failed
  }
  
  init(playerTables: [String], tournamentDayCell: TournamentDayCell) {
    let tournamentDayID = tournamentDayCell.tournamentDayID
    self.playerTables = playerTables
    self.tournamentDayCell = tournamentDayCell
    self.table = nil
    loadTournamentDay(for: tournamentDayID) { [weak self] result in
      switch result {
      case .success(let tournamentDay):
        self?.getTablePlayers(for: tournamentDay)
      default:
        self?.state = .failed
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
  
  private func getTablePlayers(for tournamentDay: TournamentDay) {
    let possibleTables = Set(playerTables)
    guard let playerTable = tournamentDay.tables.first(where: { possibleTables.contains($0)}) else { return }
    
    db.collection("Tables").getDocuments { [weak self] snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot,
              let document = snapshot.documents.first(where: { $0.documentID == playerTable }),
              let table = try? document.data(as: Table.self)
        else { return }
        self?.table = table
        self?.loadTablePlayers(for: table.seats)
      }
    }
  }
  
  private func loadTablePlayers(for tablePlayerIDs: [String]) {
    let possiblePlayerIDs = Set(tablePlayerIDs)
    db.collection("TablePlayers").getDocuments { [weak self] snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot else { return }
        let tablePlayers = snapshot.documents.compactMap {
          if possiblePlayerIDs.contains($0.documentID) {
            return try? $0.data(as: TablePlayer.self)
          }
          return nil
        }
        self?.mapTablePlayersToPokerPlayers(tablePlayers)
      }
    }
  }
  
  private func mapTablePlayersToPokerPlayers(_ tablePlayers: [TablePlayer]) {
    let dispatchGroup = DispatchGroup()
    var playerModels = [PlayerModel]()
    for tablePlayer in tablePlayers {
      dispatchGroup.enter()
      fetchPokerPlayer(for: tablePlayer) { [weak self] player in
        let playerModel = PlayerModel(playerName: player.firstName + " " + player.lastName,
                                      hometown: player.hometown,
                                      tableNumber: self?.table?.tableNumber ?? "",
                                      seatNumber: tablePlayer.seat,
                                      chipCount: tablePlayer.chipCount,
                                      bigBlinds: 0.0,
                                      hendonmobURL: player.hendonmobURL)
        playerModels.append(playerModel)
        dispatchGroup.leave()
      }
    }
    
    dispatchGroup.notify(queue: .main) {
      playerModels.sort(by: { $0.seatNumber < $1.seatNumber })
      self.players = playerModels
    }
  }
  
  private func fetchPokerPlayer(for tablePlayer: TablePlayer, completion: @escaping (PokerPlayer) -> Void) {
    db.collection("PokerPlayers").getDocuments { snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot,
              let document = snapshot.documents.first(where: {
                $0.documentID == tablePlayer.pokerPlayer
              }),
              let pokerPlayer = try? document.data(as: PokerPlayer.self)
        else { return }
        completion(pokerPlayer)
      }
    }
  }
}
