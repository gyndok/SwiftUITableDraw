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
  var tournamentID: String?
  
  // TODO: Figure out how firebase represnts dates
//  let startDate: TimeInterval
  let startingStack: UInt
  
  init(buyIn: UInt, days: [String], entries: UInt, event: String, festival: String, startingStack: UInt) {
    self.buyIn = buyIn
    self.days = days
    self.entries = entries
    self.event = event
    self.festival = festival
    self.startingStack = startingStack
    self.tournamentID = nil
  }
  
  enum CodingKeys: String, CodingKey {
    case buyIn = "buy_in"
    case days
    case entries
    case event
    case festival
    case startingStack = "starting_stack"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.buyIn = try container.decode(UInt.self, forKey: .buyIn)
    self.days = try container.decode([String].self, forKey: .days)
    self.entries = try container.decode(UInt.self, forKey: .entries)
    self.event = try container.decode(String.self, forKey: .event)
    self.festival = try container.decode(String.self, forKey: .festival)
    self.startingStack = try container.decode(UInt.self, forKey: .startingStack)
  }
}
