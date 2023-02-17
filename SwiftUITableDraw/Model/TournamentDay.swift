//
//  TournamentDay.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation

struct TournamentDay: Decodable {
  let bigBlind: UInt
  let playersRemaining: UInt
  let restartDate: TimeInterval
  let tables: [String]
  
  enum CodingKeys: String, CodingKey {
    case bigBlind = "big_blind"
    case playersRemaining = "players_remaining"
    case restartDate = "restart_date"
    case tables
  }
}
