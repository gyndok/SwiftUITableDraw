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
  private let player: PokerPlayer?
  
  init(player: PokerPlayer?) {
    self.player = player
  }
  
  func executeTournamentSearch() {
    db.collection("Tournaments").getDocuments { [weak self] snapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        guard let snapshot = snapshot else { return }
        let tournaments: [Tournament] = snapshot.documents.compactMap({
          if Set(self?.player?.tournaments ?? []).contains($0.documentID) {
            var tournament = try? $0.data(as: Tournament.self)
            tournament?.tournamentID = $0.documentID
            return tournament
          }
          return nil
        })
        self?.tournaments = tournaments
      }
    }
  }
}
