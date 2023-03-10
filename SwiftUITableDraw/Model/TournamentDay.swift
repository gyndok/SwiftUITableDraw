//
//  TournamentDay.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation
import Firebase

struct TournamentDay: Decodable {
  let bigBlind: UInt
  let playersRemaining: UInt
  let restartDate: Timestamp
  let tables: [String]
  
  enum CodingKeys: String, CodingKey {
    case bigBlind = "big_blind"
    case playersRemaining = "players_remaining"
    case restartDate = "restart_date"
    case tables
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.bigBlind = try container.decode(UInt.self, forKey: .bigBlind)
    self.playersRemaining = try container.decode(UInt.self, forKey: .playersRemaining)
    self.tables = try container.decode([String].self, forKey: .tables)
    self.restartDate = try container.decode(Timestamp.self, forKey: .restartDate)
  }
}
