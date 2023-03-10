//
//  PokerPlayer.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation

struct PokerPlayer: Decodable, Hashable {
  let firstName: String
  let lastName: String
  let hendonmobURL: String
  let hometown: String
  let tournaments: [String]
  let participatedTables: [String]

  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case hendonmobURL = "hendonmob_url"
    case hometown = "hometown"
    case tournaments
    case participatedTables = "participated_tables"
  }
}
