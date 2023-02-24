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
  
  @Published var tournaments = [Tournament]()
  private let db = Firestore.firestore()
  
  func executeTournamentSearch(for query: String) {
    let separatedName = query.components(separatedBy: " ")
    let firstName = separatedName.first
    
    var lastName: String? {
      if separatedName.count > 1 {
        var lastName = ""
        for i in 1..<separatedName.count {
          lastName.append(separatedName[i])
          lastName.append(" ")
        }
        lastName.removeLast()
        return lastName
      }
      return nil
    }
    
    let dispatchGroup = DispatchGroup()
    
    // FirstName
    dispatchGroup.enter()
    var firstNameResults = [String]()
    db.collection("PokerPlayers").whereField("first_name", isEqualTo: firstName ?? "").getDocuments { snapshot, error in
      
      defer {
        dispatchGroup.leave()
      }
      
      if let error = error {
          print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot else { return }
        let players = snapshot.documents.compactMap {
          return try? $0.data(as: PokerPlayer.self)
        }
        for player in players {
          firstNameResults.append(contentsOf: player.tournaments)
        }
      }
    }
      
    // LastName
    dispatchGroup.enter()
    var lastNameResults = [String]()
    db.collection("PokerPlayers").whereField("last_name", isEqualTo: lastName ?? "").getDocuments { snapshot, error in
      
      defer {
        dispatchGroup.leave()
      }
      
      if let error = error {
          print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot else { return }
        let players = snapshot.documents.compactMap {
          return try? $0.data(as: PokerPlayer.self)
        }
        for player in players {
          lastNameResults.append(contentsOf: player.tournaments)
        }
      }
    }
    
    dispatchGroup.notify(queue: .global()) { [weak self] in
      self?.getTournaments(for: Set(firstNameResults + lastNameResults))
    }
  }
  
  private func getTournaments(for tournamentIDs: Set<String>) {
    db.collection("Tournaments").getDocuments { [weak self] snapshot, error in
      if let error = error {
          print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot else { return }
        let tournaments: [Tournament] = snapshot.documents.compactMap({
          if tournamentIDs.contains($0.documentID) {
            var tournament = try? $0.data(as: Tournament.self)
            tournament?.tournamentID = $0.documentID
          }
          return nil
        })
        self?.tournaments = tournaments
      }
    }
  }
}
