//
//  PokerPlayer.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation

struct PokerPlayer: Decodable {
  let firstName: String
  let lastName: String
  let hendonmobURL: String
  let hometown: String

  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case hendonmobURL = "hendonmob_url"
    case hometown = "hometown"
  }
}
