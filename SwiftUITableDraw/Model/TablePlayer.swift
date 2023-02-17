//
//  TablePlayer.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation

struct TablePlayer: Decodable {
  let chipCount: UInt
  let pokerPlayer: String
  let seat: String
  
  enum CodingKeys: String, CodingKey {
    case chipCount = "chip_count"
    case pokerPlayer = "poker_player"
    case seat
  }
}
