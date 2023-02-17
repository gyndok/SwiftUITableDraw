//
//  Tournament.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation

struct Tournament: Decodable {
  let buyIn: UInt
  let day: [String]
  let entries: UInt
  let event: String
  let festival: String
  let startDate: TimeInterval
  let startingStack: UInt
  
  enum CodingKeys: String, CodingKey {
    case buyIn = "buy_in"
    case day
    case entries
    case event
    case festival
    case startDate = "start_date"
    case startingStack = "starting_stack"
  }
}
