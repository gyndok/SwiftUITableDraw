//
//  Tournament.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation

struct Tournament: Decodable {
  let buyIn: UInt
  let days: [String]
  let entries: UInt
  let event: String
  let festival: String
  
  // TODO: Figure out how firebase represnts dates
//  let startDate: TimeInterval
  let startingStack: UInt
  
  enum CodingKeys: String, CodingKey {
    case buyIn = "buy_in"
    case days
    case entries
    case event
    case festival
    case startingStack = "starting_stack"
  }
}
