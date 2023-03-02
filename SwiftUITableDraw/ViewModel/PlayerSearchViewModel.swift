//
//  PlayerSearchViewModel.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 3/1/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class PlayerSearchViewModel: ObservableObject {
  
  @Published var players = [PokerPlayer]()
  @Published var searchField = ""
  @Published var state: State = .success
  
  private let db = Firestore.firestore()
  
  enum State {
    case success
    case error
  }
  
  func searchButtonPressed() {
    let separatedName = searchField.components(separatedBy: " ")
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
    var pokerPlayerResult = [PokerPlayer]()
    
    let handleSearchResult: (Result<[PokerPlayer], Error>) -> Void = { [weak self] result in
      switch result {
      case .success(let players):
        pokerPlayerResult.append(contentsOf: players)
      case .failure:
        self?.state = .error
      }
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    executeFirstNameSearch(firstName ?? "", completion: handleSearchResult)
    
    dispatchGroup.enter()
    executeLastNameSearch(lastName ?? "", completion: handleSearchResult)
    
    dispatchGroup.notify(queue: .main) { [weak self] in
      self?.players = Array(Set(pokerPlayerResult))
    }
  }
  
  private func executeFirstNameSearch(_ firstName: String,
                                      completion: @escaping (Result<[PokerPlayer], Error>) -> Void) {
    executePokerPlayerSearch(query: firstName, field: "first_name", completion: completion)
  }
  
  private func executeLastNameSearch(_ lastName: String,
                                     completion: @escaping (Result<[PokerPlayer], Error>) -> Void) {
    executePokerPlayerSearch(query: lastName, field: "last_name", completion: completion)
  }
  
  private func executePokerPlayerSearch(query: String,
                                        field: String,
                                        completion: @escaping (Result<[PokerPlayer], Error>) -> Void) {
    db.collection("PokerPlayers").whereField(field, isEqualTo: query).getDocuments { snapshot, error in
      if let error = error {
        completion(.failure(error))
      } else {
        guard let snapshot = snapshot
        else { return }
        let players = snapshot.documents.compactMap({
          return try? $0.data(as: PokerPlayer.self)
        })
        completion(.success(players))
      }
    }
  }
  
  
}
